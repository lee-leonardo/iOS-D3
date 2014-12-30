//
//  D3iOS
//  Created by Leonardo Lee on 12/20/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//
//
//  NOTE:
//  This module requires D3.js to run properly.

var INTERACT_MODULE_D3 = (function () {

  function sendJSMessage(eventName, elem, data) {
    var event = CustomEvent(eventName, data);
    elem.dispatchEvent(event);
  }


  function setupMessageListener(eventName, elem, callback) {
    elem.addEventListener(eventName, function(d) {
      callback(d);
    });
  }

  return {
    update: function(data) {

    },

  };
})();

/*
Leo's Plan:
1. Make a module to stick functions in, since JS added to a html file SHOULD be global, this'll help differentiate and keep things tidy.
2. Thus what I'll do is have an injected script create an empty element named "svg," this'll be where the SVG will be placed.
3. Updating the SVG will be done at a later point once I have the basic stuff for generating a pie chart done.

*/

//
//  Custom Module for this project.
//

var D3_DEMO_MODULE = (function(module){

})(INTERACT_MODULE_D3);
