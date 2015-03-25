var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askIfGreaterThan(el1, el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + "?",
  function (answer) {
    if (answer.toUpperCase() === "YES") {
      callback(true);
    }
    else {
      callback(false);
    };
  });

}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  console.log(i);
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i+1], swapHelper);
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  };


  function swapHelper(isGreaterThan) {
    if (isGreaterThan) {
      console.log(arr, i);
      var a = arr[i];
      arr[i] = arr[i+1];
      arr[i+1] = a;
      madeAnySwaps = true;
    };
    innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop)
  };

}

function absurdBubbleSort(arr, sortCompletionCallback) {

  function outerBubbleSortLoop(madeAnySwaps) {

    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else {
      sortCompletionCallback(arr);
    };

  }

  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
