(function(){
  if(typeof window.Hanoi === "undefined"){
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $el){
    this.game = game;
    this.$el = $el;
    this.$firstClick = "none";
    this.$secondClick = "none";
  };

  View.prototype.drawBoard = function(){

    for (var i=0; i<3; i++){

      var $ul = $("<ul></ul>");
      $ul.addClass("tower group");
      $ul.data("pile", i);
      this.$el.append($ul);

      for (var j = 0; j< 3; j++){
        var $li = $("<li></li>");
        $li.addClass("tower-cell");
        if (i === 0) {
          $li.data("block", j + 1);
          // if (j === 0){
          //   $li.appendClass("little");
          // }else if(j===1){
          //   $li.appendClass("medium");
          // }else if(j===2){
          //   $li.appendClass("large");
          // }
        }else{
          $li.data("block", 0);
          // $li.appendClass("empty");
        }

        $ul.append($li);
      };
    };
  }

  View.prototype.render = function(){
    this.$firstClick = "none";
    this.$secondClick = "none";
    for(var i = 0; i< 9; i++){
      $cell = $(".tower-cell").eq(i);
      $cell.removeClass();
      $cell.addClass("tower-cell");
      if ($cell.data("block") === 3) {
        $cell.addClass("large");
      }else if($cell.data("block") === 2){
        $cell.addClass("medium");
      }else if($cell.data("block") === 1){
        $cell.addClass("little");
      }else{
        $cell.addClass("empty");
      }
    };
    if (this.game.isWon()){
      this.$el.find(".tower").off("click");
      this.$el.append("<h2>You win!!!!!!</h2>")
    }
  };

  View.prototype.bindEvents = function () {

    this.$el.find(".tower").on("click", function(event) {
      if (this.$firstClick === "none") {
        var $tower = $(event.currentTarget);
        this.$firstClick = $tower;
      } else if (this.$secondClick === "none") {
        var $tower = $(event.currentTarget);
        this.$secondClick = $tower;
        this.makeMove();
      }

    }.bind(this));
  };

  View.prototype.makeMove = function () {
    var madeMove = this.game.move(this.$firstClick.index(), this.$secondClick.index());
    var $cell1, $cell2, $tempCell, block;

    if (madeMove){
      for(var i = 0; i<3; i++){
        $tempCell = this.$firstClick.find(".tower-cell").eq(i)
        if ($tempCell.data("block") > 0){
          $cell1 = $tempCell;
          break;
        }
      };
      for(var i = 2; i>=0; i--){
        $tempCell = this.$secondClick.find(".tower-cell").eq(i)
        if ($tempCell.data("block") === 0){
          $cell2 = $tempCell;
          break;
        }
      };

      block = $cell1.data("block");

      $cell2.data("block", block);
      $cell1.data("block", 0);


    }
    this.render();
  };

})();
