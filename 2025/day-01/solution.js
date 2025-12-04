const getPasswordViaRotationsPart1 = () => {
    const fs = require('fs');

    const lines = fs.readFileSync("./data.txt", 'utf-8').split('\n');

    let rotations = []
    let currentPosition = 50;
    let dial = new Array(100).fill(0);
    dial[currentPosition]++;

    lines.forEach(l => {
        rotations.push([l[0], Number(l.substring(1))]);
    })

    rotations.forEach(([direction, ticks]) => {
        if (direction === "L"){
            for (let i = 0; i < ticks; i++){
                currentPosition--
                if (currentPosition < 0){
                    currentPosition = 99;
                }
            }
        } else if (direction === "R") {
            for (let i = 0; i < ticks; i++){
                currentPosition++
                if (currentPosition > 99){
                    currentPosition = 0;
                }
            }
        }
        dial[currentPosition]++;
    });

    return dial[0];
}

const getPasswordViaRotationsPart2 = () => {
    const fs = require('fs');

    const lines = fs.readFileSync("./data.txt", 'utf-8').split('\n');

    let rotations = []
    let currentPosition = 50;
    let dial = new Array(100).fill(0);
    dial[currentPosition]++;

    lines.forEach(l => {
        rotations.push([l[0], Number(l.substring(1))]);
    })

    rotations.forEach(([direction, ticks]) => {
        if (direction === "L"){
            for (let i = 0; i < ticks; i++){
                dial[currentPosition]++
                currentPosition--
                if (currentPosition < 0){
                    currentPosition = 99;
                }
            }
        } else if (direction === "R") {
            for (let i = 0; i < ticks; i++){
                dial[currentPosition]++
                currentPosition++
                if (currentPosition > 99){
                    currentPosition = 0;
                }
            }
        }
    });

    return dial[0];
}

console.log(getPasswordViaRotationsPart1());
console.log(getPasswordViaRotationsPart2());


