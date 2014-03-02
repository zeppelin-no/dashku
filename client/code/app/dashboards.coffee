# Enable the user to submit the new dashboard form if there is a name
checkDashboardFormIsReady = ->
  if $('#newDashboardModal input[name="name"]').val().length > 0
    $('#newDashboardModal button').removeAttr "disabled"
  else
    $('#newDashboardModal button').attr "disabled", "disabled"  

# Render the new dashboard modal
$(document).on 'click', 'a#newDashboard', (event) ->
  $(ss.tmpl['dashboard-newModal'].r()).modal()   

# Bind events when the login form is visible
$(document).on 'shown', '#newDashboardModal', ->
  $(@).find('button').attr "disabled", "disabled"
  $(@).on 'hidden', -> $(@).remove()
  $(@).find('input[name="name"]').keyup -> checkDashboardFormIsReady()  

# User submits the new dashboard form
$(document).on 'submit', '#newDashboardModal form', ->
  ss.rpc 'dashboard.create', serializeFormData(@), (response) ->
    if response.status is "success"
      $('#newDashboardModal').modal 'hide'
      Dashboard.select response.dashboard
    else
      $('#newDashboardModal input[name="name"]').val('').attr('placeholder', response.reason).parent().addClass('control-group error')
  return false

# Clear the error style when the user focuses on the password field
$(document).on 'focus', '#newDashboardModal input[name="name"]', (event) ->
  $(@).parent().removeClass('control-group error')

# Display the dashboard on the page
$(document).on 'click', 'a.showDashboard', ->
  Dashboard.select $(@).attr('data-id')

# Record the previous value, in case the user decides not to update the field
$(document).on 'focus', 'h1.name', (event) ->
  $(@).attr 'data-previousName', $(@).text()

# Revert to the previous value, unless the user has pressed the enter key to submit the change
$(document).on 'blur', 'h1.name', (event) ->
  unless window.dontRevert?
    $(@).text $(@).attr 'data-previousName'
  else
    window.dontRevert = undefined

# Update the dashboard with the new name
$(document).on 'keypress', 'h1.name', (event) ->
  if event.keyCode is 13
    window.dontRevert = true
    $(@).blur()
    _id = $('#widgets').attr('data-dashboardId')
    name = $(@).text()
    ss.rpc 'dashboard.update', {_id,name}
    false
    
# Delete dashboard confirmation dialog and response handler    
$(document).on 'click', 'a#deleteDashboard', ->
  if confirm("Delete the dashboard?")
    ss.rpc 'dashboard.delete', Dashboard.selected._id, (response) ->
      $('#editDashboardModal').modal 'hide'
      alert response.reason if response.status isnt 'success'

# Make the dashboard fluid width
$(document).on 'click', 'a#screenWidth', ->
  newScreenWidth = if Dashboard.selected.screenWidth is 'fixed' then 'fluid' else 'fixed'
  ss.rpc 'dashboard.update', _id: Dashboard.selected._id, screenWidth: newScreenWidth

# Load the CSS editor for the dashboard
$(document).on 'click', 'a#styleDashboard', ->
  cssEditor.init Dashboard.selected


#### SS event bindings ####


# A new dashboard has been created.
# Add it to the data bucket,
# and render it in the menu items list
ss.event.on 'dashboardCreated', (dashboard, channelName) ->
  Dashboard.add dashboard
  $('#dashboardMenuItems').prepend ss.tmpl['dashboard-dashboardMenuItem'].render dashboard
  sortDashboardMenuList('ul#dashboardMenuItems', 'li[data-dashboardid]')

# An existing dashboard has been updated.
# Update the data bucket,
# update the dashboards menu list item, and
# update the view rendering of that dashboard
# if it is currently selected.
ss.event.on 'dashboardUpdated', (dashboard, channelName) ->
  Dashboard.update dashboard
  if Dashboard.selected? and Dashboard.selected._id is dashboard._id
    Dashboard.selected = dashboard
    $('.dashboard h1.name').text dashboard.name
    renderCSS dashboard.css
    renderScreenSize dashboard.screenWidth
  $('#dashboardMenuItems').find("li[data-dashboardId='#{dashboard._id}']").replaceWith ss.tmpl['dashboard-dashboardMenuItem'].render dashboard
  sortDashboardMenuList('ul#dashboardMenuItems', 'li[data-dashboardid]')

# An existing dashboard has been deleted.
# Remove the dashboard from the data bucket, 
# remove it's item from the dashboards menu,
# and deselect it if it is currently on display.
ss.event.on 'dashboardDeleted', (dashboardId, channelName) ->
  Dashboard.remove dashboardId  
  $('#dashboardMenuItems').find("li[data-dashboardId='#{dashboardId}']").remove()
  Dashboard.select Dashboard.all[0] if Dashboard.selected._id is dashboardId