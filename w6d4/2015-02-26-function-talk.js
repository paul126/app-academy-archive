// equivalent, just functions (only boring difference is hoisting and being a named vs anonymous function)

var a = function(){};
function a (){};

// 4 ways we can call functions
// 1. function style --> this == window
// 2. method style --> this == object function is called on (before the dot)
// 3. constructor style --> this == blank new object
// 4. apply/call --> this == whatever our heart desires

var a = function(){
  console.log(this);
  return "something";
};

a()
// this == window / global object
// return == "something"

var x = {
  a: a
};

x.a();
// this == x
// return == "something"

var b = x.a;

b // <- function
b() // this == global && return == "something"


var c = x.a();

c // <- "something"
c() // error "something" is not function




new a();
// this == new object that is created {}
// return == new object that is created ...

a.apply(3);
// this == 3
// return == "something"

a.call(4);
// this == 4
// return == "something"

// difference between call and apply:
// .call() <- takes seq of args
// .apply() <- takes array of args










var a = function(){
  return this.something;
};

var obj = {
  something: "something"
};

var invokeCallback = function(callback){
  return callback();
}

invokeCallback( ??? ) // want to "something"

invokeCallback(a.bind(obj));

// 3 ways to control "this" in function:
// .bind(thing) -> returns a new function with "this" set to thing
// .apply(thing) -> invokes function with "this" set to thing
// .call(thing) -> invokes function with "this" set to thing




// BAD SOLUTIONS

invokeCallback(a);
// undefined --> this == window

invokeCallback(obj);
// error: obj is not a function

invokeCallback(function(){
  a();
});
// undefined --> anonymous function doesn't return anything (undefined)

invokeCallback(function(){
  return a();
});
// undefined --> this == window


// var x = (function(){
//   return a();
// })()

// x = undefined

invokeCallback((function(){
  return a();
})());
// error: undefined is not a function

// STEPS LEADING TO ERROR
// 1. anonymous function is immediately invoked
// 2. a is called function style
// 3. this == window
// 4. window.something == undefined
// 5. undefined gets passed as callback
// 6. undefined is not a function






















// class A
//
//   def self.b
//     ...
//   end
//
//   def c
//     ...
//   end
//
// end


var invokeCallback = function(callback){
  return callback("happy message");
}


var a = function (){
  console.log(this);

  // this.constructor.b();
  // a.b();


  c // not here, doesn't exist

  invokeCallback(c); // error no c found

  invokeCallback(this.c); // --> console.logs the window

  invokeCallback(this.c()); // --> console.logs(instance), then error undefined is not a function

  this.d // function

  invokeCallback(this.d); // return window.something ... undefined

  invokeCallback( this.d.bind(this) );


  var that = this;

  invokeCallback(this.d.bind(that));

  invokeCallback(function(){
    return this.d();
  });


  this.something = "something";

  invokeCallback(this.e.bind(this));

  invokeCallback(this.e.bind(this, "super happy message"));
  // inside this.e function:
  // message == "super happy message"
  // arguments == ["super happy message", "happy message"]



  var that = this;

  invokeCallback(function(anything){
    return that.e(anything);
  });

};

a.b = function(){
  console.log(this);
}

a.prototype.c = function(){
  console.log(this);
}

a.prototype.d = function(){
  return this.something;
}

a.prototype.e = function(message) {
  return "hello " + this.something + " " + message;
}


var x = new a();

a.b()
// this == a
