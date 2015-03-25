var cat = {
  name: "Sennacy",
  sayHi: function () {
    return "meow my name is " + this.name;
  },
  addTwoNums: function (num1, num2) {
    return this.name + " says this is the sum: " + (num1 + num2);
  }
};

var numFunk = cat.addTwoNums;



Function.prototype.myBind = function(context) {
  var fn = this;
  return fn.apply(context);
}

console.log(numFunk())
console.log(numFunk.myBind(cat))
