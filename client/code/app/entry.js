'use strict';
// This file gets called automatically by SocketStream and must always exist
//
// GLOBALS
// - ss
//


// Make 'ss' available to all modules and the browser console
window.ss = require('socketstream');



ss.server.on('disconnect', function () {
	$('a.brand div').addClass('disconnected').attr('title', 'The connection to the server is severed, you may need to reload the page.');
});



ss.server.on('reconnect', function () {
	$('a.brand div').removeClass('disconnected').attr('title', 'The connection to the server is back');
});



ss.server.on('ready', function () {

	// Wait for the DOM to finish loading
	$(function () {
		// Load app
		require('/ee');
		require('/helpers');
		require('/account');
		require('/docs');
		require('/changePassword');
		require('/app');
		require('/login');
		require('/dashboards');
		require('/widgets');
		window.editor2    = require('/editor2');
		window.cssEditor  = require('/cssEditor');
		window.signup     = require('/signup');
	});
		
});