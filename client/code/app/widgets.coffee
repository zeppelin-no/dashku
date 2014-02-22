#### Widgets ####

# The state manager for the new widget modal
newWidgetState = new StateManager '#step'
newWidgetState.addState 'choose', -> $('#step').html ss.tmpl['widget-choose'].r()
newWidgetState.addState 'templates', -> 
  $('#step').html ss.tmpl['widget-templates'].render widgetTemplates: WidgetTemplate.all
  
# Load the step1 template when the new widget modal is visible
$(document).on 'shown', '#newWidgetModal', ->
  newWidgetState.setState 'choose'

# Show the new widget modal
$(document).on 'click', 'a#newWidget', (event) ->
  $(ss.tmpl['widget-newModal'].r()).modal()
  
# Remove the new widget modal from the DOM once hidden
$(document).on 'hidden', '#newWidgetModal', ->
  $(@).remove()

# Adds a new widget to the dashboard
$(document).on 'click', '.option#buildWidget', (event) ->
  $("#newWidgetModal").modal 'hide'
  ss.rpc 'widget.create', dashboardId: Dashboard.selected._id, (response) ->
    if response.status is 'success'
      # do nothing
    else
      # do nothing

# Display the widgetTemplates list in the new widget modal
$(document).on 'click ', '.option#widgetFromTemplate', (event) ->
  newWidgetState.setState 'templates'

# Bind the "go back" button to display the choose state in the new widget modal
$(document).on 'click', 'a#goBack', (event) ->
  newWidgetState.setState 'choose'  

# Bind the click on a widget template to create a widget from the template
$(document).on 'click', '.widgetTemplate', (event) ->
  ss.rpc 'widget.create', dashboardId: Dashboard.selected._id, widgetTemplateId: $(@).attr('data-id'), (response) ->
    if response.status is 'success'
      $("#newWidgetModal").modal 'hide'
    else
      alert "There was an error - #{response.reason}"

# Bind the Return key on the widget name to update the name on the widget
$(document).on 'keypress', '.widget .header', (event) ->
  if event.keyCode is 13
    window.dontRevert = true
    $(@).blur()
    ss.rpc 'widget.update', dashboardId: Dashboard.selected._id, _id: $(@).parent().attr('data-id'), name: $(@).text(), (response) ->
      if response.status is 'success'
        # Nothing to do, the name is already updated
      else
        # TODO - figure out a nice, generic way to handle these errors
        alert "There was an error - #{response.reason}"

# Record the previous value, in case the user decides not to update the field
$(document).on 'focus', '.widget .header', (event) ->
  $(@).attr 'data-previousName', $(@).text()

# Revert to the previous value, unless the user has pressed the enter key to submit the change
$(document).on 'blur', '.widget .header', (event) ->
  unless window.dontRevert?
    $(@).text $(@).attr 'data-previousName'
  else
    window.dontRevert = undefined

# Edit the widget
$(document).on 'click', '.widget .edit', ->
  widget = $(@).parent().parent()
  widget.addClass 'editMode'
  Widget.select widget.attr 'data-id'
  $('body').append $('<div id="overlay"></div>').hide().fadeIn 500
  editor2.init Dashboard.selected._id, Widget.selected, ->
    Widget.selected = null
    $('#overlay').fadeOut 250, ->
      $('#overlay').remove()
      widget.removeClass 'editMode'

# Delete the widget
$(document).on 'click', '.widget .delete', ->
  id = $(@).parent().parent().attr 'data-id'
  if confirm "Are you sure you want to delete the widget?"
    ss.rpc 'widget.delete', _id: id, dashboardId: Dashboard.selected._id


#### Events ####

# Bind on a new widget being created
ss.event.on 'widgetCreated', (data, channelName) ->
  index = Dashboard.all.indexOf(Dashboard.find(data.dashboardId))
  Dashboard.all[index].widgets.push data.widget
  if Dashboard.selected._id is data.dashboardId
    Widget.add data.widget, ->
      $('#widgets').append ss.tmpl['dashboard-widget'].render data.widget
      widget = Widget.find data.widget._id
      widget.eventEmitter = new EE code: widget.script, id: widget._id, scriptType: widget.scriptType
      makeWidgetsResizeable $(".widget[data-id='#{widget._id}']")

# A helper function to detect if only the name changed on the widget.
# This is so that we don't perform unnecessary re-rendering of the
# widget.
#
# TODO - check if this belongs in a better location
window.onlyNameChanged = (currentWidget, newWidget) ->
  changedValues = []
  for key, value of currentWidget
    changedValues.push key if currentWidget[key] isnt newWidget[key] and ['updatedAt','eventEmitter'].indexOf(key) is -1
  return changedValues.length is 1 and changedValues[0] is "name"

# Bind on when a widget is updated. A lot of things happen here.
ss.event.on 'widgetUpdated', (data, channelName) ->
  
  # Select the widget model object in the data Bucket
  dashboardIndex  = Dashboard.all.indexOf(Dashboard.find(data.dashboardId))
  widgetObject    = item for item in Dashboard.all[dashboardIndex].widgets when item['_id'] is data.widget._id
  widgetIndex     = Dashboard.all[dashboardIndex].widgets.indexOf widgetObject

  # Check if only the name was updated
  if onlyNameChanged(widgetObject, data.widget)
    # Just update the widget's name
    Dashboard.all[dashboardIndex].widgets[widgetIndex] = data.widget
    if Dashboard.selected._id is data.dashboardId
      $('#widgets').find(".widget[data-id='#{data.widget._id}']").find('.header').text data.widget.name
  else
    # Update the widget model in the Widget bucket,
    # and re-render the widget
    #
    # TODO - find a better way to bind view-rendering to the model changes.
    Dashboard.all[dashboardIndex].widgets[widgetIndex] = data.widget
    if Dashboard.selected._id is data.dashboardId
      widgetView = $('#widgets').find(".widget[data-id='#{data.widget._id}']")
      widgetView.find('.content').html($(ss.tmpl['dashboard-widget'].render(data.widget)).find('.content').html())
      widgetView.find('style').text data.widget.scopedCSS
      widgetView.css width: "#{data.widget.width}px", height: "#{data.widget.height}px"
      Widget.update data.widget 
      
# Bind on when a widget is deleted      
ss.event.on 'widgetDeleted', (data, channelName) ->

  # Select the widget model object in the data Bucket
  dashboardIndex = Dashboard.all.indexOf(Dashboard.find(data.dashboardId))
  widgetObject    = item for item in Dashboard.all[dashboardIndex].widgets when item['_id'] is data.widgetId
  widgetIndex     = Dashboard.all[dashboardIndex].widgets.indexOf widgetObject

  # Remove it from the dashboard Bucket 
  Dashboard.all[dashboardIndex].widgets.splice widgetIndex, 1 if widgetIndex isnt -1
  if Dashboard.selected._id is data.dashboardId
    # Remove it from the widget bucket
    Widget.remove data.widgetId, ->
      # Remove it from the view
      widget = $('#widgets').find(".widget[data-id='#{data.widgetId}']")
      widget.fadeOut 'slow', -> widget.remove()

# Bind on the transmission event, where a widget receives data
ss.event.on 'transmission', (data, channelName) ->
    widget = Widget.find(data._id)
    widget.eventEmitter.emit('transmission', data) if widget? and widget.eventEmitter.widget.parent().hasClass('editMode') is false

# Bind on the widget's positions being updated
ss.event.on 'widgetPositionsUpdated', (data, channelName) ->
  dashboard = Dashboard.find data._id
  for widget in dashboard.widgets
    widget.position = data.positions[widget._id]

  if Dashboard.selected._id is data._id
    for widget in Widget.all
      # A sneaky way of updating the items in the collection without triggering a reload
      # TODO - find a better way
      widget.position = data.positions[widget._id] 

    # Sort the widgets in the Widget Bucket by their position number
    Widget.all.sort (a,b) -> a.position - b.position

    # Reorder the widgets on the page. 
    # TODO - Refactor this bit of code 
    # as it is duplicated in app.coffee
    for widget in Widget.all
      index = Widget.all.indexOf(widget)
      if index < Widget.all.length
        $(".widget[data-id='#{widget._id}']")
        .after($(".widget[data-id='#{Widget.all[index+1]._id}']")) 