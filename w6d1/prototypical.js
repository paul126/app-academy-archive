Function.prototype.inherits = function(superClass) {
  function Surrogate () {};
  Surrogate.prototype = superClass.prototype;
  this.prototype = new Surrogate();
}

function MovingObject () {
  this.name = "hahaha";
};

MovingObject.prototype.move = function() {
  console.log("flying");
}

function Ship () {};
Ship.inherits(MovingObject);

function Asteroid () {};
Asteroid.inherits(MovingObject);
