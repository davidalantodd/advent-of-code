const { count } = require('console');
const fs = require('fs');
const data = fs.readFileSync("./data.txt", 'utf-8').split('\n');

const checkSurroundingLessThan4 = (paperRollData, lineIndex, columnIndex) => {
    let countOfSurroundingRolls = 0;
    //U
    if (lineIndex > 0){
        if (paperRollData[lineIndex-1][columnIndex] === "@"){
            countOfSurroundingRolls++;
        }
    }
    //UR
    if (lineIndex > 0 && columnIndex < paperRollData[lineIndex].length - 1){
        if (paperRollData[lineIndex-1][columnIndex+1] === "@"){
            countOfSurroundingRolls++;
        }
    }
    //R
    if (columnIndex < paperRollData[lineIndex].length - 1){
        if (paperRollData[lineIndex][columnIndex+1] === "@"){
            countOfSurroundingRolls++;
        }
    }
    //DR
    if (lineIndex < paperRollData.length - 1 && columnIndex < paperRollData[lineIndex].length - 1){
        if (paperRollData[lineIndex+1][columnIndex+1] === "@"){
            countOfSurroundingRolls++;
        }
    }
    //D
    if (lineIndex < paperRollData.length - 1){
        if (paperRollData[lineIndex+1][columnIndex] === "@"){
            countOfSurroundingRolls++;
        }
    }
    //DL
    if (lineIndex < paperRollData.length - 1 && columnIndex > 0){
        if (paperRollData[lineIndex+1][columnIndex-1] === "@"){
            countOfSurroundingRolls++;
        }
    }
    //L
    if (columnIndex > 0){
        if (paperRollData[lineIndex][columnIndex-1] === "@"){
            countOfSurroundingRolls++;
        }
    }
    //UL
    if (lineIndex > 0 && columnIndex > 0){
        if (paperRollData[lineIndex-1][columnIndex-1] === "@"){
            countOfSurroundingRolls++;
        }
    }
    return countOfSurroundingRolls < 4;
}

const findNumberOfAccessiblePaperRolls = (paperRollData) => {
    let numberOfAccessiblePaperRolls = 0;
    paperRollData.forEach((line, lineIndex) => {
        line.split("").forEach((position, columnIndex) => {
            if (position === "@" && checkSurroundingLessThan4(paperRollData, lineIndex, columnIndex)){
                numberOfAccessiblePaperRolls++
            }
        });
    });
    return numberOfAccessiblePaperRolls;
};

const findNumberOfAccessiblePaperRollsPart2 = (paperRollData) => {
    let totalNumberOfRollsRemoved = 0;
    let numberOfAccessiblePaperRolls = 0;
    paperRollData = paperRollData.map((line) => {
        return line.split("")
    })
    do {
        numberOfAccessiblePaperRolls = 0;
        paperRollData.forEach((line, lineIndex) => {
            line.forEach((position, columnIndex) => {
                if (position === "@" && checkSurroundingLessThan4(paperRollData, lineIndex, columnIndex)){
                    numberOfAccessiblePaperRolls++
                    paperRollData[lineIndex][columnIndex] = "x";
                }
            });
        });
        totalNumberOfRollsRemoved += numberOfAccessiblePaperRolls;
    } while (numberOfAccessiblePaperRolls != 0);
    return totalNumberOfRollsRemoved;
};

console.log("part1: ", findNumberOfAccessiblePaperRolls(data));
console.log("part2: ", findNumberOfAccessiblePaperRollsPart2(data));