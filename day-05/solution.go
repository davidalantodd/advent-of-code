package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

func main() {

	content, err := ioutil.ReadFile("data.txt")

	if err != nil {
		log.Fatal(err)
	}

	// fmt.Println(string(content))

	data := strings.Split(string(content), "\n\n")

	crates := make([]string, 0)
	procedure := make([]string, 0)
	tempString := ""

	//iterate over the crates with for-each range loop
	for _, character := range data[0] {
		if character != '\n' {
			tempString += string(character)
		} else {
			crates = append(crates, string(tempString))
			tempString = ""
		}
		// fmt.Print(character, "- ")
		// fmt.Println(string(character))
	}
	crates = append(crates, string(tempString))

	lenCrates := len(crates)
	numStacksStr := string(crates[lenCrates-1][len(crates[lenCrates-1])-2])
	numStacks, err := strconv.Atoi(numStacksStr)
	// fmt.Println(numStacks)
	tempString=""

	//iterate over the procedure with for-each range loop
	for _, character := range data[1] {
		if character != '\n' {
			tempString += string(character)
		} else {
			procedure = append(procedure, string(tempString))
			tempString = ""
		}
	}

	procedure = append(procedure, string(tempString))
	// fmt.Println(len(procedure))

	//iterate through the stacks and create 2D slices to represent stacks
	stacks := make([][]string, numStacks)
	stacksCopy := make([][]string, numStacks)
	for i := 0; i < numStacks; i++ {
		oneStack := []string{}
		for j := lenCrates-1; j >= 0; j-- {
			// fmt.Println("crates:", (crates[j]))
			if string(crates[j][int(1+(i*4))]) != " " {
				oneStack = append(oneStack, string(crates[j][int(1+(i*4))]))
				stacks[i] = append(stacks[i], string(crates[j][int(1+(i*4))]))
				stacksCopy[i] = append(stacksCopy[i], string(crates[j][int(1+(i*4))]))

			}
		}
		// fmt.Println("oneStack: ",oneStack)
		// fmt.Println(len(oneStack))
		// stacks[i] = make([]int, 0)
	}

	//iterate through the moves to move the crates from stack to stack
	for i := 0; i < len(procedure); i++{
		splitMoves := strings.Split(string(procedure[i]), " ")
		whatMove, err := strconv.Atoi(splitMoves[1])
		from, err := strconv.Atoi(splitMoves[3])
		to, err := strconv.Atoi(splitMoves[5])

		for j:=0; j < whatMove; j++{
			crateToMove := stacks[from-1][len(stacks[from-1])-1]
			stacks[from-1] = stacks[from-1][:len(stacks[from-1])-1]
			// fmt.Println(whatMove)
			stacks[to-1] = append(stacks[to-1], crateToMove)
			if err != nil {fmt.Println(err)}
			// fmt.Println(string(procedure[i]))
		}
		// fmt.Println(stacks)
	}

	// fmt.Println("stacksCopy", stacksCopy)
	// fmt.Println("stacks", stacks)

	//part 2 - iterate through the moves to move the crates in groups
	for i := 0; i < len(procedure); i++{
		splitMoves := strings.Split(string(procedure[i]), " ")
		whatMove, err := strconv.Atoi(splitMoves[1])
		from, err := strconv.Atoi(splitMoves[3])
		to, err := strconv.Atoi(splitMoves[5])

		groupOfCrates:=[]string{}
		groupOfCrates = stacksCopy[from-1][len(stacksCopy[from-1])-whatMove:len(stacksCopy[from-1])]
		// fmt.Println("group of crates", groupOfCrates)
		
		stacksCopy[from-1] = stacksCopy[from-1][:len(stacksCopy[from-1])-whatMove]
		stacksCopy[to-1] = append(stacksCopy[to-1], groupOfCrates...)
		// fmt.Println(stacksCopy, i, procedure[i])
		if err != nil {fmt.Println(err)}
	}

	//iterate through stacks to find final solution
	finalCratesOnTop := ""
	finalCratesOnTopPart2 := ""
	for i := 0; i < numStacks; i++ {
		finalCratesOnTop += stacks[i][len(stacks[i])-1]
		finalCratesOnTopPart2 += stacksCopy[i][len(stacksCopy[i])-1]
	}

	fmt.Println("solution to part 1: ", finalCratesOnTop)
	fmt.Println("solution to part 2: ", finalCratesOnTopPart2)

}
