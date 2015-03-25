var sum = function() {

  var argumentsArray = Array.prototype.slice.call(arguments);
  var total = 0;

  for (var i=0; i < argumentsArray.length; i++) {
    total += argumentsArray[i];
  }
  return total;
};

// console.log(sum(1,2,3,4,5,6,7,8,9,10));

Function.prototype.myBind = function(obj) {

  var argArr = Array.prototype.slice.call(arguments);

  var func = this;

  var newFunc = function () {
    return func.apply(obj, argArr);
  };

  return newFunc;
};

// var Cat = function (name) {
//   this.name = name;
// }
//
// Cat.prototype.meow = function () {
//
//   console.log(this.name + " says meow!");
//   console.log(arguments[1])
// };
//
// var curie = new Cat("Curie")
// setTimeout(curie.meow.myBind(curie, 100 ,2,3), 1000);

var curriedSum = function(numArgs) {
  var numbers = [];
  var total = 0;

  var _curriedSum = function(num) {
    console.log(num);
    numbers.push(num);
    if (numbers.length === numArgs) {
      //console.log("got here with array " + numbers );
      for (var i=0; i < numbers.length; i++) {
        total += numbers[i];
      }
      return total;
    }
    else {
      return _curriedSum;
    }
  }

  return _curriedSum;

};

// var sum1 = curriedSum(4);
// console.log(sum1(5)(30)(20)(1)); // => 56

Function.prototype.curry = function(numArgs) {

  var argArr = [];
  var fn = this;

  var _curry = function (arg) {
    argArr.push(arg);

    if (argArr.length === numArgs) {
      return fn.apply(null, argArr);
    } else {
      return _curry;
    };
  };

  return _curry;

};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// you'll write `Function#curry`!
var f1 = sumThree.curry(3);
var f2 = f1(4);
var f3 = f2(20);
var result = f3(6); // = 30

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30
