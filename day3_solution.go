package main

import (
    "fmt"
    "io/ioutil"
	"os"
	"strings"
)

func main() {
    content, err := ioutil.ReadFile("day3_given-tree_map.txt")

    if err != nil {
        fmt.Println("An error occurred. Please try again.")
		os.Exit(1)
    }

    mapInput := strings.Split(string(content), "\n")
	xCount1,xCount3,xCount5,xCount7 := 0,0,0,0
	trees1,trees2,trees3,trees4,trees5:= 0,0,0,0,0

	for yCount := 0; yCount < (len(mapInput)-1); yCount++ {
		//Puzzle 2 - right 1, down 1
		if mapInput[yCount][xCount1] == '#' {
			trees1++
		}
		//Puzzle 1 - right 3, down 1
		if mapInput[yCount][xCount3] == '#' {
			trees2++
		}
		//Puzzle 2 - right 5, down 1
		if mapInput[yCount][xCount5] == '#' {
			trees3++
		}
		//Puzzle 2 - right 7, down 1
		if mapInput[yCount][xCount7] == '#' {
			trees4++
		}
		yCount2 := yCount*2
		if yCount2 < (len(mapInput)-1) {
			//Puzzle 2 - right 1, down 2
			if mapInput[yCount2][xCount1] == '#' {
				trees5++
			}
		}
		//DEBUG:fmt.Println("x",xCount,"y",yCount,"||",mapLineHolder[yCount],"||",treesEncountered)
		xCount1 = (xCount1+1) % 31
		xCount3 = (xCount3+3) % 31
		xCount5 = (xCount5+5) % 31
		xCount7 = (xCount7+7) % 31
	}

	treeProduct := trees1*trees2*trees3*trees4*trees5
	fmt.Println("Puzzle 1:",trees2,"trees encountered.")
	fmt.Println("Puzzle 2:",treeProduct,"trees encountered.")
}
