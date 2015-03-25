(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  Asteroids.Util = {};

Asteroids.Util.inherits = function(ChildClass, ParentClass) {
  function Surrogate () {};
  Surrogate.prototype = ParentClass.prototype;
  ChildClass.prototype = new Surrogate();
}

Asteroids.Util.randomVec = function(maxLength) {
  length = Math.random() * maxLength;
  var arr = [0,0];

  arr[0] = Math.random() * length;
  arr[1] = Math.sqrt(length * length - arr[0] * arr[0]);

  return arr;
}

})();
