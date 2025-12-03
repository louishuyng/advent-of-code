package main

import (
	"fmt"
	"os"
)

func main() {
	data, err := os.ReadFile(os.Args[1])
	if err != nil {
		fmt.Println("Error reading file:", err)
		os.Exit(1)
	}

	dataStr := string(data)
	lines := splitLines(dataStr)

	totalJoltage := 0
	for _, bank := range lines {
		joltage := findMaxJoltage(bank)
		totalJoltage += joltage
	}

	fmt.Println("Total Joltage:", totalJoltage)
}

func splitLines(s string) []string {
	var lines []string
	start := 0
	for i := 0; i < len(s); i++ {
		if s[i] == '\n' {
			lines = append(lines, s[start:i])
			start = i + 1
		}
	}

	return lines
}

func findMaxJoltage(bank string) int {
	n := len(bank)
	max := 0

	for i := range n {
		first := int(bank[i] - '0')
		for j := i + 1; j < n; j++ {
			second := int(bank[j] - '0')
			sum := first*10 + second

			if sum > max {
				max = sum
			}
		}
	}

	return max
}
