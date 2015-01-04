function createDataStruct(num) {
  var rng = roll(num);
  var structure = [];

  for (var i = 0; i < rng.length; i++) {
    structure.push({"value":rng[i]});
  }
  return structure;
}

function roll(num) {
  var set = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  for (var i = 0; i < num; i++) {
    var rolledNum = newRoll();
    set[rolledNum]++;
  }

  return set
}

function newRoll() {
  return Math.floor(Math.random() * 10);
}

// console.log(createDataStruct(10));

function fireOffCustomEvent() {
  var event = CustomEvent('D3_iOS_REFRESH');
  window.document.getElementById('D3_CHART').dispatchEvent(event);
}

console.log(createDataStruct(10));
