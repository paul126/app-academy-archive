function Clock () {
  this.hours = 0;
  this.seconds = 0;
  this.minutes = 0;
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  console.log(this.hours + ":" + this.minutes + ":" + this.seconds);
};

Clock.prototype.run = function () {

  date = new Date();
  this.hours = date.getHours();
  this.seconds = date.getSeconds();
  this.minutes = date.getMinutes();

  this.printTime();
  setInterval(this._tick.bind(this), 5000);
};

Clock.prototype._tick = function () {
  this.seconds += 5;
  if (this.seconds > 59) {
    this.seconds -= 60;
    this.minutes++;
  };
  if (this.minutes > 59) {
    this.minutes -= 60;
    this.hours++;
  };
  if (this.hours > 23 ) {
    this.hours -= 24;
  };
  this.printTime();
};

var clock = new Clock();
clock.run();
