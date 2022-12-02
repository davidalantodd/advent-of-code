#include <stdio.h>

int main() {
    //read file contents
    FILE * fPtr;

    //create variables for each line's content, total points, turns
    char lineContent[5];
    int totalPoints = 0;
    char opponentTurn;
    char yourTurn;

    //start reading file
    fPtr = fopen("data.txt", "r");

    //read the file line by line, looping until the end of the file
    while (fgets(lineContent, 5, fPtr) != NULL){
        opponentTurn = lineContent[0];
        yourTurn = lineContent[2];

        /*
            take two chars.. if/else statements to determine winner
            A - Rock, B - Paper, C - Scissors
            X - Rock, Y - Paper, Z - Scissors
        */
        //if opponent plays rock
        if (opponentTurn == 'A'){       
            if (yourTurn == 'Y'){
                totalPoints += (6 + 2);       //win with paper
            } else if (yourTurn == 'X'){
                totalPoints += (3 + 1);       //tie with rock
            } else {
                totalPoints += 3; //played scissors
            }
        //if opponent plays paper
        } else if (opponentTurn == 'B'){    
            if (yourTurn == 'Z'){
                totalPoints += (6 + 3);       //win with scissors
            } else if (yourTurn == 'Y'){
                totalPoints += (3 + 2);       //tie with paper
            } else {
                totalPoints += 1; //played rock
            }
        //if opponent plays scissors
        } else if (opponentTurn == 'C'){
            if (yourTurn == 'X'){
                totalPoints += (6 + 1);       //win with rock
            } else if (yourTurn == 'Z'){
                totalPoints += (3 + 3);       //tie with scissors
            } else {
                totalPoints += 2; //played paper
            }
        }

        // printf("%i", totalPoints);
        // printf("%s", lineContent);
        // printf("%c\n", opponentTurn);
        // printf("%c\n", yourTurn);
    }

    //stop reading file
    fclose(fPtr);

    
    //print sum of points
    printf("Your total Score is: %i", totalPoints);

    return 0;
}