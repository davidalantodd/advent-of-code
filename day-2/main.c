#include <stdio.h>

int main() {
    //read file contents
    FILE * fPtr;

    //create variables for each line's content, total points, turns
    char lineContent[5];
    int totalPointsRPS = 0; //total points for part 1 (second column is rock/paper/scissors)
    int totalPointsLWD = 0; //total points for part 2 (second column is lose/win/draw)
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
                totalPointsRPS += (6 + 2);       //win with paper
                totalPointsLWD += (3 + 1);       //part 2 version..
            } else if (yourTurn == 'X'){
                totalPointsRPS += (3 + 1);       //tie with rock
                totalPointsLWD += (0 + 3);       //part 2 version..
            } else {
                totalPointsRPS += 3; //played scissors
                totalPointsLWD += (6 + 2);       //part 2 version..
            }
        //if opponent plays paper
        } else if (opponentTurn == 'B'){    
            if (yourTurn == 'Z'){
                totalPointsRPS += (6 + 3);       //win with scissors
                totalPointsLWD += (6 + 3);       //part 2 version..
            } else if (yourTurn == 'Y'){
                totalPointsRPS += (3 + 2);       //tie with paper
                totalPointsLWD += (3 + 2);       //part 2 version..
            } else {
                totalPointsRPS += 1; //played rock
                totalPointsLWD += (0 + 1);       //part 2 version..
            }
        //if opponent plays scissors
        } else if (opponentTurn == 'C'){
            if (yourTurn == 'X'){
                totalPointsRPS += (6 + 1);       //win with rock
                totalPointsLWD += (0 + 2);       //part 2 version..
            } else if (yourTurn == 'Z'){
                totalPointsRPS += (3 + 3);       //tie with scissors
                totalPointsLWD += (6 + 1);       //part 2 version..
            } else {
                totalPointsRPS += 2; //played paper
                totalPointsLWD += (3 + 3);       //part 2 version..
            }
        }


        // printf("%i", totalPointsLWD);
        // printf("%s", lineContent);
        // printf("%c\n", opponentTurn);
        // printf("%c\n", yourTurn);
    }

    //stop reading file
    fclose(fPtr);

    
    //print sum of points
    printf("Your total Score is: %i\n", totalPointsRPS);
    printf("In part 2 version (LWD), your total Score is: %i\n", totalPointsLWD);

    return 0;
}