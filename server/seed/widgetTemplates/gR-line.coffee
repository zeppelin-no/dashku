module.exports =
  name: 'gR Line'
  json: '{ "data": 3 }'
  script: '(function () {\n  var widget = this.widget.get(0)\n    , self = this\n    , x = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]\n    , data = [ 9, 1, 5, 6, 4, 2, 5, 3, 1, 0 ]\n\n  self.on(\'load\', function () {\n    head.js( \'javascripts/raphael-min.js\'\n      , \'javascripts/g.raphael-min.js\'\n      , \'javascripts/g.line-min.js\'\n      )\n    head.ready(function () {\n      var r = Raphael(widget)\n\n      var line = update()\n\n      self.on(\'transmission\', function (rec) {\n        data.shift()\n        data.push(rec.data)\n        r.clear()\n        line = update()\n      })\n\n      function update () {\n        return r.linechart(10, 0, 150, 150, x, data, { axis: "0 0 1 1" })\n      }\n    })\n  })\n}.call(this))\n'
  css: '{\n  background-color: white;\n}\n.header {\n  color: black;\n}\n\n'
  html: ''
  snapshotUrl: "/images/widgetTemplates/grLine.png"
