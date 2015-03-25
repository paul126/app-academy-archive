(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }


var GameView = Asteroids.GameView = function() {
  this.game = new Asteroids.Game();
  this.ctx;
}

GameView.prototype.start = function (canvasEl) {

  this.ctx = canvasEl.getContext("2d");
  gameship = this.game.ship;
  game = this.game;
  key('up', function() { gameship.vel[1] -= 1 });
  key('down', function() { gameship.vel[1] += 1 });
  key('left', function() { gameship.vel[0] -= 1 });
  key('right', function() { gameship.vel[0] += 1 });
  key('space', function() { new Asteroids.Bullet(gameship, game)});

  // key('up', function() { gameship.power('U'); }.bind(gameship));
  // key('down', function() { gameship.power('D'); }.bind(gameship));
  // key('left', function() { gameship.power('L'); }.bind(gameship));
  // key('right', function() { gameship.power('R'); }.bind(gameship));
  debugger
  window.setInterval((function () {
    this.game.step();
    this.game.draw(this.ctx);

  }).bind(this), 20);
};



})();
