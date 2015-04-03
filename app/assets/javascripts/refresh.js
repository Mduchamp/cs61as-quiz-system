/* Checks for specific condition every 5 seconds and refreshes certain page when the condition is met. */
var refreshVar = setInterval(function() { checkRequests() }, 5000);
function checkRequests() {
	//grab ruby object and refresh the page once if condition is true
	if (//) {
		alert("Now grabbing ruby objects");
	} else {
		stopRequests();
	}
	//if not call stopRequests
}

function stopRequests() {
    clearInterval(refreshVar);
}