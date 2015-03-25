(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }


  var MovingObject = Asteroids.MovingObject = function() {
    this.pos = arguments[0].pos;
    this.vel = arguments[0].vel;
    this.radius = arguments[0].radius;
    this.color = arguments[0].color;
    this.game = arguments[0].game;
  };

  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI ,
      false
    );

    ctx.fill();

  };

  MovingObject.prototype.move = function() {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
    this.pos = this.game.wrap(this.pos);
  }

  MovingObject.prototype.isCollidedWith = function(obj) {
    
    var xDiff = this.pos[0] - obj.pos[0];
    var yDiff = this.pos[1] - obj.pos[1];
    var radTotal = this.radius + obj.radius;
    var distance = Math.sqrt((xDiff*xDiff) + (yDiff*yDiff));

    if (distance < radTotal) {
      return true;
    }
    else {
      return false;
    };
  };



})();
