(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

var COLOR = "#00CCCC";
var RADIUS = 15;
var MAX_SPEED = 1;

var Asteroid = Asteroids.Asteroid = function(pos, game) {
  var params = {pos: pos,
                vel: Asteroids.Util.randomVec(MAX_SPEED),
                radius: RADIUS,
                color: COLOR,
                game: game
  };
  Asteroids.MovingObject.call(this, params);
};

Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);



})();
