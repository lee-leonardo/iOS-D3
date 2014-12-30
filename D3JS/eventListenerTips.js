// Event basic
var event = new Event('NAME');
// Custom Event, still listened to the EventListener.
var custom = new CustomEvent('NAME', { 'property' : elem.dataset.time });

// This adds a listener to an event or CustomEvent
elem.addEventListener('NAME', function(e){}, false);

// Dispatches an event to an object (could I do this to a module)?
elem.dispatchEvent(event);


/*
//Event
new Event('NAME');
the init
*/

/*
//Custom Event
initCustomEvent(type, canBubble, cancelable, detail);
new CustomEvent(type, eventInitDict);

//Properties
type: "", //The name.
eventInitDict: object //JSON object that contains object properties. (For the new CustomEvent() else just detail.)
canBubble: bool, //Defaults false
cancelable: bool, //Defaults false
detail: any //Data
*/
