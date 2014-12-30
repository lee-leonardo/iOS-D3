function randData(num) {
  var dataObj = {
    "1" : 0,
    "2" : 0,
    "3" : 0,
    "4" : 0,
    "5" : 0,
    "6" : 0,
    "7" : 0,
    "8" : 0,
    "9" : 0,
    "10" : 0
  };

  var set = roll(num);

  for (var i = 0; i < set.length; i++) {
    var label = set[i].toString();
    dataObj[label] += 1;
  }

  return dataObj;
}

function roll(num) {
  var set = [];

  for (var i = 0; i < num; i++) {
    set.push(newRoll());
  }

  return set
}

function newRoll() {
  return Math.floor(Math.random() * 10 + 1);
}

// console.log(randData(10));
