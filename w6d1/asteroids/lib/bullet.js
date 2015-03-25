(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

var Bullet = Asteroids.Bullet = function(ship, game) {
  this.pos = ship.pos;
  this.vel = ship.vel;
  this.vel[0] *= 2;
  this.vel[1] *= 2;
  this.radius = 1;
  this.color = "black";
  this.game = game;
}



Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);



})();
