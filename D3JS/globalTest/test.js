//Global Function
function addedPText() {
  var list = document.querySelectorAll('p.added_p');
  for (var i=0; i < list.length; i++) {
    console.log(list[i].innerHTML);
  }
}

//Module
var MOD = (function (){

  //Not visible function
  function displayText(text) {
    console.log("This should never fire!, " + text );
  }

  return {
    //Visible function
    addElement: function(text) {
      var p = document.createElement('p'),
      text = document.createTextNode(text);
      p.className = "added_p";
      // p.id = "";
      p.appendChild(text);
      document.body.appendChild(p);
    }
  }
})();
