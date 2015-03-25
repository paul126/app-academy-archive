var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function HanoiGame() {
  this.stacks = [[3,2,1], [], []];
};

HanoiGame.prototype.isWon = function () {

  if ((this.stacks[1][0] === 3 &&
      this.stacks[1][1] === 2 &&
      this.stacks[1][2] === 1) ||
     (this.stacks[2][0] === 3 &&
      this.stacks[2][1] === 2 &&
      this.stacks[2][2] === 1)) {
        return true;
      } else {
        return false;
      };
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {

  var startTower = this.stacks[startTowerIdx];
  var endTower = this.stacks[endTowerIdx];

  if (startTower.length === 0) {
    return false;
  } else if (endTower.length === 0) {
    return true;
  };

  origPiece = this.stacks[startTowerIdx].slice().pop();
  endPiece = this.stacks[endTowerIdx].slice().pop();

  if (origPiece > endPiece) {
    return false;
  }
  else {
    return true;
  }

}

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx, c) {


  if (!this.isValidMove.bind(this, startTowerIdx, endTowerIdx)) {
    console.log("Invalid Move.")
  };
  this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    this.run(c);

};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function(callback, c) {
  this.print();
  var startTowerIdx, endTowerIdx;

  reader.question("Choose the starting tower: ",
    function(answer1) {
      reader.question("Choose the ending tower: ",
        function(answer2) {
          startTowerIdx = parseInt(answer1);
          endTowerIdx = parseInt(answer2);
          callback(startTowerIdx, endTowerIdx, c);
        });
  });
};

HanoiGame.prototype.run = function (completionCallback) {

  if (!this.isWon()) {
    this.promptMove(this.move.bind(this), completionCallback);
  }
  else {
    completionCallback();
  };

};


h = new HanoiGame;
h.run( function () { console.log("Congrats! You win.");
reader.close();
  });
