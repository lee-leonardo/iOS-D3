var DATAG_MOD = (function(){
  var labels = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];

  return {
    newDataSet : function() {
      var labelSet = labels,
      dataSet = [];

      for (var i = 0; i < labelSet.length; i++) {
        var entry = { "label" : labelSet[i], "value" : Math.floor(Math.random() * 100) };
        dataSet.push(entry);
      }

      return dataSet;
    }
  };
});

//Tests the data set. Working well.
//console.log(DATAG_MOD.newDataSet());

/*
//This is just stuff that I used to help create this. I am thinking about create a simulated roll example at some point, but this will work for the time being.

var labels = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];

function newData() {
  var dataSet =  [
{
  "label" : "One",
  "value" : 0
},
{
  "label" : "Two",
  "value" : 0
},
{
  "label" : "Three",
  "value" : 0
},
{
  "label" : "Four",
  "value" : 0
},
{
  "label" : "Five",
  "value" : 0
},
{
  "label" : "Six",
  "value" : 0
},
{
  "label" : "Seven",
  "value" : 0
},
{
  "label" : "Eight",
  "value" : 0
},
{
  "label" : "Nine",
  "value" : 0
},
{
  "label" : "Ten",
  "value" : 0
}
];

for (entry in struct) {
  entry.value = Math.random() * 100 + 1;
}

console.log(struct);
return dataSet;
}
*/
