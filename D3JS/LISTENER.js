//
//  D3iOS
//  Created by Leonardo Lee on 12/20/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//
//
//  NOTE:
//  This module requires D3.js to run properly.

/*
Leo's Plan:
  1. Make a module to stick functions in, since JS added to a html file SHOULD be global, this'll help differentiate and keep things tidy.
  2. Thus what I'll do is have an injected script create an empty element named "svg," this'll be where the SVG will be placed.
  3. Updating the SVG will be done at a later point once I have the basic stuff for generating a pie chart done.
*/

var LISTENER_MODULE = (function () {

  var listeners = new Object();

  function sendJSMessage(eventName, elem, data) {
    var event = CustomEvent(eventName, data);
    elem.dispatchEvent(event);
  }

  function setupMessageListener(eventName, elem, callback) {
    elem.addEventListener(eventName, function(d) {
      callback(d);
    });
  }

  function checkForListener(name) {
    if (listeners[name]) {
      return true;
    } else {
      return false;
    }
  }

  return {
    update: function(data) {

    },
    sendMessage: function(name, element, data) {

    },
    addListener: function(name, element, callback) {
      if (!checkForListener(name)) {
        setupMessageListener(name, element, callback);
      } else {
        console.log("Listener's name exists.");
      }
    },
  };
})();

//
//  Custom Module for this project.
//

var D3_DEMO_MODULE = (function(module){
  //This will augment the old module by giving it some extra functions and such.
  var d3el = window.document.body.getElementById("svg"); //This should grab the svg object in the browser.

  //This adds a listener to the event refresh.
  // module.addListener("D3_REFRESH", d3el, function(data) {
    // window.document.
  // });

  return module;

})(LISTENER_MODULE);
