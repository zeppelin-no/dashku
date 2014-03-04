'use strict';



// Dependencies
//
var selenium              = require('selenium-launcher');
var soda                  = require('soda');
process.env.SS_ENV        = 'cucumber';
var ss                    = require('socketstream');
var config                = require('../../server/config');
require('../../app');


// Stub the output for now
//
ss.api.log.debug 	= function (){};
ss.api.log.info 	= function (){};


var browser = null;

var World = function (callback) {

	var wrap = function (funk, cb) {
		funk.end(function (err) {
			if (err) {
				cb.fail(err);
			} else {
				cb();
			}
		});
	};

	var shouldBeOnThePage = function (browser, callback, selector) {
		wrap(browser.chain.waitForElementPresent(selector), callback);
	};

	if (browser === null) {
		selenium(function (err, selenium) {

			process.on('exit', function () { selenium.kill(); });

			var newBrowser = soda.createClient({
				host    : selenium.host,
				port    : selenium.port,
				url     : config[ss.env].apiHost,
				browser : 'firefox'
			});

			browser = newBrowser;

			callback({browser: browser, wrap: wrap, shouldBeOnThePage: shouldBeOnThePage});
		});
	} else {
		callback({browser:browser, wrap: wrap, shouldBeOnThePage: shouldBeOnThePage});
	}
};



exports.World = World;