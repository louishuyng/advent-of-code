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
	rotations, err := readFileAndParseRotations(os.Args[1])
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
	totalZeros := 0

	for _, rotation := range rotations {
		var zeros int
		var end int

		switch rotation.Operation {
		case RightRotate:
			end = startPoint + rotation.Amount
			// Count multiples of 100 crossed: floor(end/100) - floor(start/100)
			zeros = end/100 - startPoint/100
		case LeftRotate:
			end = startPoint - rotation.Amount
			// Count zeros crossed: ceil(start/100) - ceil(end/100)
			zeros = ceilDiv(startPoint, 100) - ceilDiv(end, 100)
		}

		totalZeros += zeros
		startPoint = ((end % 100) + 100) % 100
	}

	return totalZeros
}

func ceilDiv(a, b int) int {
	if a > 0 {
		return (a + b - 1) / b
	}
	return a / b // Go truncates toward zero, which is ceiling for negatives
}
