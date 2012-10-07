module.exports =
  name: 'Red Green'
  json: '{}'
  scriptType: 'javascript'
  script: '(function () {\n  var widget = this.widget.get(0)\n    , self = this\n\n  self.on(\'load\', function () {\n    head.js(\'javascripts/d3.v2.min.js\')\n    head.ready(function () {\n      var chart = d3.select(widget)\n        .append(\'svg\')\n        .attr(\'viewBox\', \'0 0 200 180\')\n        .append(\'circle\')\n        .attr(\'r\', 70)\n        .attr(\'cx\', 100)\n        .attr(\'cy\', 80)\n        .attr(\'fill\', \'red\')\n        .attr(\'stroke\', \'white\')\n\n      self.on(\'transmission\', function (ndata) {\n        update()\n      })\n\n      function update () {\n        chart.transition()\n            .delay(10)\n            .duration(10)\n            .attr(\'fill\', \'limegreen\')\n          .transition()\n            .delay(100)\n            .duration(100)\n            .attr(\'fill\', \'green\')\n          .transition()\n            .delay(3000)\n            .duration(3000)\n            .attr(\'fill\', \'red\')\n      }\n    })\n  })\n}.call(this))\n\n'
  css: ''
  html: ''
  snapshotUrl: "/images/widgetTemplates/redgreen.png"