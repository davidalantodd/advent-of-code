const {readFileSync, promises: fsPromises} = require('fs')

//reading file data
const file_data = readFileSync('./data.txt', 'utf-8');

const arrayOfContents = file_data.split('\n');

//initializing data to traverse data in an array
let arrayOfCalorieSums = [];
let currentSum = 0;

//loop through data to determine the sum of calories each elf is carrying
for (let i = 0; i < arrayOfContents.length; i++){
    let currentCalorie = arrayOfContents[i];
    //if the current line is a calorie/number, then add it to the current sum
    if (currentCalorie !== ''){
        currentSum += Number(currentCalorie)
    //if the current line is an empty line, then push the sum onto the array and reset the current sum
    } else {
        arrayOfCalorieSums.push(currentSum);
        currentSum = 0;
    }
}
arrayOfCalorieSums.push(currentSum);

//use .max() and spread operator to return max calories
let maxElfCalories = Math.max(...arrayOfCalorieSums);

console.log("The total calories the elf is carrying that has the most calories total: ", maxElfCalories);

//part 2
let sortedArrayOfCalories = arrayOfCalorieSums.sort((a,b) => b-a);

let sumOfTopThreeCalorieElves = sortedArrayOfCalories[0] + sortedArrayOfCalories[1] + sortedArrayOfCalories[2];

// console.log(sortedArrayOfCalories);

console.log("The total calories of the top three calorie-carrying elves: ", sumOfTopThreeCalorieElves);
