(function(){
  if(typeof window.SnakeGame === "undefined"){
    window.SnakeGame = {};
  }

  var View = SnakeGame.View = function ($el) {
    this.board = new SnakeGame.Board();
    this.$el = $el;

    $(document).on("keydown", this.handleKeyEvent.bind(this));
    setInterval(this.step.bind(this), 500);
  };

  View.prototype.handleKeyEvent = function(event){
    if (event.keyCode === 37){
      this.board.snake.turn["W"];
    }else if(event.keyCode === 38){
      this.board.snake.turn["N"];
    }else if(event.keyCode === 39){
      this.board.snake.turn["E"];
    }else if(event.keyCode === 40){
      this.board.snake.turn["S"];
    }
  };

  View.prototype.step = function(){
    this.board.snake.move();
    this.board.render();
  }




})();
