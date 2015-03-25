(function(){
  if(typeof window.SnakeGame === "undefined"){
    window.SnakeGame = {};
  }

  function Snake(){
    this.dir = "S";
    this.segments = [[10,10],[11,10],[12,10]];
  };

  Snake.prototype.move = function() {
    var lastIDX = this.segments.length - 1;
    var head = this.segments[lastIDX];
    this.segments.shift();

    if (this.dir === "S"){
      this.segments.push([head[0] + 1, head[1]]);
    } else if (this.dir === "N"){
      this.segments.push([head[0] - 1, head[1]]);
    } else if (this.dir === "E"){
      this.segments.push([head[0], head[1] + 1]);
    } else if (this.dir === "W"){
      this.segments.push([head[0], head[1] - 1]);
    }
  };
  Snake.prototype.length = function(){
    return this.segments.length;
  }

  Snake.prototype.turn = function (newDir) {
    this.dir = newDir;
  };

  var Board = SnakeGame.Board = function(){
      this.board = [];
      this.snake = new Snake();

      for (var i = 0; i < 20; i++) {
        this.board.push([]);
        for (var j = 0; j < 20; j++) {
          this.board[i].push([0]);
        };
      };
  };

  Board.prototype.render = function() {
    var len = this.snake.length();
    var x,y;
    for (var i = 0; i < 20; i++) {

      for (var j = 0; j < 20; j++) {
        this.board[i][j] = "_";
      };
    };
    for (var i = 0; i < len; i++){
      x = this.snake.segments[i][0];
      y = this.snake.segments[i][1];
      this.board[x][y] = "S";
    }

    console.log(this.board);

  };



})();
