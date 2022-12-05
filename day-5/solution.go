package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

func main() {
	// fmt.Println("Hello world.")

	content, err := ioutil.ReadFile("example.txt")

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
		fmt.Println(character)
	}
	crates = append(crates, string(tempString))

	lenCrates := len(crates)
	numStacksStr := string(crates[lenCrates-1][len(crates[lenCrates-1])-2])
	numStacks, err := strconv.Atoi(numStacksStr)
	fmt.Println(numStacks)

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
	fmt.Println(len(procedure))

	stacks := make([][]string, numStacks)
	for i := 0; i < numStacks; i++ {
		oneStack := []string{}
		for j := lenCrates - 1; j >= 0; j-- {
			if string(crates[j][int(i)]) != " " {
				oneStack = append(oneStack, string(crates[j][int(1+(i*4))]))
				stacks[i] = append(stacks[i], string(crates[j][int(1+(i*4))]))
			} else {
				fmt.Println("found a space")
			}
		}
		fmt.Println(oneStack)
		fmt.Println(len(oneStack))
		// stacks[i] = make([]int, 0)
	}
}

//to run, go run solution
