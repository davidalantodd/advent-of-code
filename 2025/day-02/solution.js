const getInvalidIDsPart1 = () => {
    const fs = require('fs');

    const ids = fs.readFileSync("./data.txt", 'utf-8').split(',');
    let invalidIds = [];

    ids.forEach(id => {
        const [a, b] = id.split("-");
        for (let i = Number(a); i <= Number(b); i++){
            const firstHalf = i.toString().substring(0, i.toString().length / 2);
            const secondHalf = i.toString().substring(i.toString().length / 2);
            if (firstHalf == secondHalf){
                invalidIds.push(Number(firstHalf + secondHalf))
            }
        }
    });
    
    return invalidIds.reduce((a, c) => a + c);
}

const getInvalidIDsPart2 = () => {
    const fs = require('fs');

    const ids = fs.readFileSync("./data.txt", 'utf-8').split(',');
    let invalidIds = [];

    ids.forEach(id => {
        const [a, b] = id.split("-");
        outerloop: for (let i = Number(a); i <= Number(b); i++){
            let numberOfRepeater = 2;
            while (numberOfRepeater <= i.toString().length){
                for (let repeaterTest = (Math.floor(i.toString().length / numberOfRepeater)); repeaterTest >= 1; repeaterTest--){
                    let tester = i.toString().substring(0, repeaterTest);
                    if (tester.repeat(numberOfRepeater) == i){
                        invalidIds.push(i);
                        continue outerloop;
                    }
                }
                numberOfRepeater++;
            }
        }
    });
    return invalidIds.reduce((a, c) => a + c);
}

console.log(getInvalidIDsPart1());
console.log(getInvalidIDsPart2());


