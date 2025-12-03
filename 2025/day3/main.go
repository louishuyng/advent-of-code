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

	var totalJoltage int64 = 0
	for _, bank := range lines {
		joltage := findMaxJoltage(bank, 12)
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

func findMaxJoltage(bank string, pick int) int64 {
	n := len(bank)
	if n < pick {
		return 0
	}

	// Greedy approach: for each digit position, pick the largest digit
	// that still leaves enough digits for remaining picks

	var result int64 = 0
	startPos := 0

	for i := 0; i < pick; i++ {
		remaining := pick - i   // digits still to pick (including this one)
		endPos := n - remaining // last valid position to pick from

		// Find the maximum digit in range [startPos, endPos]
		maxDigit := byte('0')
		maxIdx := startPos
		for j := startPos; j <= endPos; j++ {
			if bank[j] > maxDigit {
				maxDigit = bank[j]
				maxIdx = j
			}
		}

		// Add this digit to result
		result = result*10 + int64(maxDigit-'0')

		// Next pick must start after this position
		startPos = maxIdx + 1
	}

	return result
}
