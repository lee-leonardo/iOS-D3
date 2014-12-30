
function sendJSMessage(eventName, elem, data) {
  var event = CustomEvent(eventName, data);
  elem.dispatchEvent(event);
}


function setupMessageListener(eventName, elem, callback) {
  elem.addEventListener(eventName, function(d) {
    callback(d);
  });
}

//Sampler.
var element = window.document.body.getElementById("svg");
var functionName = function (arg) {
  // arg["type"]
  // arg["value"]
}

setupMessageListener('D3_PIE_UPDATE', element, functionName);
sendJSMessage("D3_PIE_UPDATE", element, {});
