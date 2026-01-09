const fs = require('fs');
const data = fs.readFileSync("./data.txt", 'utf-8').split('\n');

const findLargestPossibleJoltage = (batteryData) => {
    let totalJoltage = 0;
    batteryData.forEach((bank) => {
        let firstHighest = {value: -1, index: -1};
        let secondHighest = {value: -1, index: -1};
        let joltage;
        bank = bank.split("");
        bank.forEach((battery, index) => {
            joltage = Number(battery);
            if (joltage > firstHighest.value && (index < bank.length - 1)){
                firstHighest.value = joltage;
                firstHighest.index = index;
            }
        });
        for (let index = firstHighest.index + 1; index < bank.length; index++){
            joltage = Number(bank[index]);
            if (joltage > secondHighest.value){
                secondHighest.value = joltage;
                secondHighest.index = index;
            }
        }
        totalJoltage += Number(String(firstHighest.value) + String(secondHighest.value));

    })

    return totalJoltage;
}

const findLargestPossibleJoltagePart2 = (batteryData) => {
    let totalJoltage = 0;
    batteryData.forEach((bank) => {
        let highestNumbers = [{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1},{value: -1, index: -1}];
        let joltage;
        bank = bank.split("");
        // find first joltage in bank
        bank.forEach((battery, index) => {
            joltage = Number(battery);
            if (joltage > highestNumbers[0].value && (index < bank.length - 11)){
                 highestNumbers[0].value = joltage;
                 highestNumbers[0].index = index;
            }
        });
        // find remaining 11 joltages
        for (let batteryJoltageCounter = 1; batteryJoltageCounter < 12; batteryJoltageCounter++){
            for (let index = highestNumbers[batteryJoltageCounter-1].index + 1; (index < bank.length - (11 - (batteryJoltageCounter))); index++){
                joltage = Number(bank[index]);
                if (joltage > highestNumbers[batteryJoltageCounter].value){
                    highestNumbers[batteryJoltageCounter].value = joltage;
                    highestNumbers[batteryJoltageCounter].index = index;
                }
            }
        }
        
        // sum all joltages by concat-ing all highest numbers
        totalJoltage += Number(highestNumbers.reduce((acc, curr) => {
            return acc + String(curr.value)
        }, ""));
    })

    return totalJoltage;
}

console.log("part1: ", findLargestPossibleJoltage(data));
console.log("part2: ", findLargestPossibleJoltagePart2(data));