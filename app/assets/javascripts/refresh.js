/* Checks for specific condition every 5 seconds and refreshes certain page when the condition is met. */
var refreshVar = setInterval(function() { checkRequests() }, 3000);
function checkRequests() {
	//grab ruby object and refresh the page once if condition is true
	alert("Now refreshing till ruby statement is true");
}

function stopRequests() {
	location.reload();
    clearInterval(refreshVar);
}