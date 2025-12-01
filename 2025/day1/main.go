package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Operator string

const (
	LeftRotate  Operator = "L"
	RightRotate Operator = "R"
)

type Rotation struct {
	Operation Operator
	Amount    int
}

func main() {
	rotations, err := readFileAndParseRotations("input")
	if err != nil {
		fmt.Println("Error reading rotations:", err)
		return
	}

	fmt.Printf("Rotations: %+v\n", rotations)

	calculatedPassword := calculatePassword(rotations)
	fmt.Printf("Calculated Password: %d\n", calculatedPassword)
}

func readFileAndParseRotations(filename string) ([]Rotation, error) {
	fileContent, err := os.ReadFile(filename)

	if err != nil {
		return nil, err
	}

	lines := strings.Split(string(fileContent), "\n")
	var rotations []Rotation

	for _, line := range lines {
		if len(line) == 0 {
			continue
		}
		// Format L34 or R12
		// [L/R][amount]
		op := Operator(line[0])
		amount, err := strconv.Atoi(line[1:])
		if err != nil {
			return nil, fmt.Errorf("invalid rotation format: %s", line)
		}
		rotations = append(rotations, Rotation{Operation: op, Amount: amount})
	}

	return rotations, nil
}

func calculatePassword(rotations []Rotation) int {
	startPoint := 50
	dialPoints := 0

	for _, rotation := range rotations {
		switch rotation.Operation {
		case LeftRotate:
			startPoint -= rotation.Amount
		case RightRotate:
			startPoint += rotation.Amount
		}
		startPoint = (startPoint + 100) % 100 // wrap around 0-99

		if startPoint == 0 {
			dialPoints += 1
		}
	}

	return dialPoints
}
