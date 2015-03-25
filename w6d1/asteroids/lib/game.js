(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }


var Game = Asteroids.Game = function() {
  this.asteroids = [];
  this.ship = new Asteroids.Ship([300,300], this);
  
  this.addAsteroids();
};

var DIM_X = 600;
var DIM_Y = 600;
var NUM_ASTEROIDS = 40;

Game.prototype.randomPosition = function() {
  var pos = [0,0];
  pos[0] = Math.random() * DIM_X;
  pos[1] = Math.random() * DIM_Y;
  return pos;
};

Game.prototype.addAsteroids = function() {

  for(var i = 0; i < NUM_ASTEROIDS; i++) {
    this.asteroids.push(new Asteroids.Asteroid(this.randomPosition(),this));
  };

};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, DIM_X, DIM_Y);

  for(var i = 0; i < this.allObjects().length; i++){
    this.allObjects()[i].draw(ctx);
  };

};

Game.prototype.moveObjects = function() {

  for(var i = 0; i < this.allObjects().length; i++){
    this.allObjects()[i].move();
  };
};

Game.prototype.wrap = function(pos) {
  if (pos[0] > DIM_X) {
    pos[0] = 0;
  }
  else if (pos[0] < 0){
    pos[0] = DIM_X;
  };

  if (pos[1] > DIM_Y) {
    pos[1] = 0;
  }
  else if (pos[1] < 0) {
    pos[1] = DIM_Y;
  };
  return pos;
};

Game.prototype.checkCollisions = function() {
  var length = this.allObjects().length
  for (var i = 0; i < length; i ++) {
    for (var j = i + 1; j < length; j++) {
      if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])) {
        if (this.allObjects()[j] instanceof Asteroids.Ship){
          this.remove(i);
          this.allObjects()[j].relocate;
        }
        else {
          this.remove(i);
          this.remove(j-1);
        };
      };
    }
  }
};

Game.prototype.step = function() {
  this.moveObjects();
  this.checkCollisions();
}

Game.prototype.remove = function(idx1) {
  this.asteroids.splice(idx1, 1);
}

Game.prototype.allObjects = function() {
  return this.asteroids.concat(this.ship);
};
})();
