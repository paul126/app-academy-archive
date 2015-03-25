var readline = require('readline');
reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function sumNumbers (numTimes) {
  addNumbers(0, numTimes, isComplete);
}



function addNumbers(sum, numsLeft, completionCallback) {

  reader.question("Enter a number: ", function (numString) {
      num = parseInt(numString);
      sum += num;
      console.log(sum);
      numsLeft -= 1;
      if (numsLeft === 0) {
        completionCallback(sum);
      } else {
        addNumbers(sum, numsLeft, completionCallback);
      };
  });
}

function isComplete(sum) {
  console.log("Congrats! You're done and the sum was " + sum);
  reader.close();
}

sumNumbers(5);
