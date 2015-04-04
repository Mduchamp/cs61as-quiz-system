/* Checks for specific condition every 5 seconds and refreshes certain page when the condition is met. */
var refreshVar = setInterval(function() { checkRequests() }, 15000);
function checkRequests() {
//grab ruby object and refresh the page once if condition is true
	location.reload();
}
function stopRequests() {
 location.reload();
 clearInterval(refreshVar);
}