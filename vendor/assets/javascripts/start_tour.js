// Create the tour, scroll to the top at the end
var tour = new Tour({
	onEnd: function(tour) {
		$("html, body").animate({ scrollTop: 0 }, "fast");
		return false;
	}
});

// Set up some common functions
var windowWidth = $(window).innerWidth();

var toggleNotification = function() {
	if (windowWidth > 979) {
		$("#notifications").click();
	}
}
var triggerNavCollapse = function() {
	if (windowWidth < 979) {
		$("#collapse-dropdown").click();
	}	
}

// Add the steps
tour.addSteps([
  {
    element: "#tour-nav",
    title: "Navigation",
    content: "You can filter questions by popularity, date, view our list of tags and ask a question.",
	placement: "top",
},
{
	element: "#questions-index",
	title: "These are questions",
	content: "Check here regularly for the latest questions and a chance to earn some points.",
	placement: "top"
},
{
	element: "td.votes-count:first",
	title: "Votes",
	content: "This box shows the number of votes for this question...",
	placement: "top",
},
{
	element: "td.answers-count:first",
	title: "Answers",
	content: "..and this shows the number of answers submitted. It turns green when an answer has been accepted.",
	placement: "top",
	onNext: function(tour) {
		triggerNavCollapse();
	 }
},
  {
    element: "#search",
    title: "Search",
    content: "Find interesting questions and solutions to your swing issues.",
	placement: "bottom",
	onPrev: function(tour) {
		triggerNavCollapse();
	 }
},
  {
    element: "#notifications",
    title: "Notifications",
    content: "Click here for activity notifications. Look you already have one.",
	placement: "bottom",
	onShow: function(){
		setTimeout(function(){
			toggleNotification();
		}, 1000);
	},
	onNext: function(){
		toggleNotification();
	}
},
{
	element: "#user-profile-tour",
	title: "Profile and Teebox score",
	content: "Your Teebox score and profile. Increase your score by answering questions and leaving helpful comments. Votes are +5 and accepted answers are +12.",
	placement: "bottom",
	onNext: function(tour) {
		triggerNavCollapse();
	 }
},
{
	element: "#welcome-start-tour",
	title: "Wrap up",
	content: "Well that should be enough to get you going. You can always click to view the tour again. Have fun!",
	placement: "top",
}
]);

var startTour = function(){
	tour.init();
	tour.restart();
}

$(function(){
	$(document).on("click", "#welcome-start-tour", function(event){
		event.preventDefault();
		if (window.location.pathname == "/"){
			startTour();
		} else {
			var url = "/?" + $("#welcome-start-tour").data("ref");
			window.location = url;
		}
	})
});

$(function(){
	if (window.location.href.indexOf("?welcome-tour") > -1) {
		startTour();
	}
});