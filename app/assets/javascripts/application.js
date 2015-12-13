// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// = require foundation
//= require facebook
//= require flipclock
//= require jquery.li-scroller.1.0
//= require_tree .

// include Foundation
$(function(){ $(document).foundation(); });

// countdown timer
var clock;
$(document).ready(function() {

	// Grab the current date
	var currentDate = new Date();

	// Set date in future - world malaria day april 25, 2016
	var futureDate  = new Date(currentDate.getFullYear() + 1, 3, 25);

	// Calculate the difference in seconds between the future and current date
	var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;

	// instantiate a coutdown FlipClock
	clock = $('.clock').FlipClock(diff, {
		clockFace: 'DailyCounter',
		countdown: true,
		showSeconds: true
	});
});


// quiz form
$('#saveForm').click(function(e){ 
	// when clicked
	console.log('clicked');
	// log each value
	$("#form_1079436 :checked").each(function(i){
		console.log($(this).val());
		console.log(i);
	});
	return false;
});

// ticker
$(document).ready(function() {
	$("ul#ticker01").liScroll(function(){
			travelocity: 0.10
	});
});