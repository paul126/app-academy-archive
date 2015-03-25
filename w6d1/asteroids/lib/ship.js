(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var COLOR = "red";
  var RADIUS = 3;
  var Ship = Asteroids.Ship = function(pos, game) {
    var params = {pos: pos,
                  vel: [0,0],
                  radius: RADIUS,
                  color: COLOR,
                  game: game
    };
    Asteroids.MovingObject.call(this, params);
  };


  Ship.prototype.relocate = function() {
    this.pos = [300, 300];
    this.vel = [0,0];
  };

  Ship.prototype.power = function(impulse) {
    switch(impulse) {
    case "U":
      this.vel[1] -= 1;
      break;
    case "D":
      this.vel[1] += 1;
      break;
    case "L":
      this.vel[0] -= 1;
      break;
    case "R":
      this.vel[0] += 1;
      break;
    };
  };

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);


})();
