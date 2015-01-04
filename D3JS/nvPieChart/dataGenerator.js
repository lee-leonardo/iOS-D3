var DATAG_MOD = {
  "labels" : ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"],
  "newDataSet" : function() {
    var labelSet = DATAG_MOD.labels,
        dataSet = [];

    for (var i = 0; i < labelSet.length; i++) {
      var entry = { "label" : labelSet[i], "value" : Math.floor(Math.random() * 100) };
      dataSet.push(entry);
    }

    return dataSet;
  }
}



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
