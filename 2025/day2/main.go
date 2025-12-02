package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

// isInvalid checks if a number is made of a sequence repeated twice
// e.g., 55 (5+5), 6464 (64+64), 123123 (123+123)
func isInvalid(n int64) bool {
	s := strconv.FormatInt(n, 10)

	// Must have even length to be a repeated sequence
	if len(s)%2 != 0 {
		return false
	}

	half := len(s) / 2
	return s[:half] == s[half:]
}

func main() {
	// Read input from file or use the example
	var input string

	if len(os.Args) > 1 {
		data, err := os.ReadFile(os.Args[1])
		if err != nil {
			fmt.Println("Error reading file:", err)
			os.Exit(1)
		}
		input = strings.TrimSpace(string(data))
	} else {
		// Example input
		input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
	}

	// Remove any whitespace/newlines
	input = strings.ReplaceAll(input, "\n", "")
	input = strings.ReplaceAll(input, " ", "")

	// Parse ranges
	ranges := strings.Split(input, ",")

	var totalSum int64 = 0

	for _, r := range ranges {
		r = strings.TrimSpace(r)
		if r == "" {
			continue
		}

		parts := strings.Split(r, "-")
		if len(parts) != 2 {
			fmt.Printf("Skipping invalid range: %s\n", r)
			continue
		}

		start, err1 := strconv.ParseInt(parts[0], 10, 64)
		end, err2 := strconv.ParseInt(parts[1], 10, 64)

		if err1 != nil || err2 != nil {
			fmt.Printf("Error parsing range: %s\n", r)
			continue
		}

		for n := start; n <= end; n++ {
			if isInvalid(n) {
				totalSum += n
			}
		}
	}

	fmt.Println("Sum of all invalid IDs:", totalSum)
}
