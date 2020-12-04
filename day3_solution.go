package main

import (
    "fmt"
    "io/ioutil"
	"strings"
)

func main() {
    content, err := ioutil.ReadFile("day3_given-tree_map.txt")

    if err != nil {
        fmt.Println("An error occurred. Please try again.")
    }

    mapInput := strings.Split(string(content), "\n")
	xCount := 0
	treesEncountered := 0

	for yCount := 0; yCount < (len(mapInput)-1); yCount++ {
		//fmt.Println("x",xCount,"y",yCount,"||",mapInput[yCount],"||",treesEncountered)

		/* I just learned about Golang slices and I'm confused.
		 I think when I am trying to reference the data with the below line,
		 I end up  actually changing the slice size, which leads to...
		 panic: runtime error: index out of range */

		//apparently the below is a messy solution in real world scenario.
		//luckily it's not working here anyways
		mapLineHolder := append([]string(nil), mapInput...) 
		//what golang slices blog recommends:
		//mapLineHolder := make([]string, len(mapInput), cap(mapInput))
		//copy(mapLineHolder, mapInput)

		if(mapLineHolder[yCount][xCount] == '#') {
			treesEncountered++
		}
		xCount = (xCount+3) % 32
	}

	fmt.Println("Puzzle 1: ",treesEncountered," trees encountered.")
}
