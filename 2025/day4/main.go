package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	var grid []string

	// Read from input.txt
	file, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Println("Error opening file:", err)
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line != "" {
			grid = append(grid, line)
		}
	}

	rows := len(grid)
	cols := len(grid[0])

	// 8 directions: up, down, left, right, and 4 diagonals
	directions := [][2]int{
		{-1, -1}, {-1, 0}, {-1, 1},
		{0, -1}, {0, 1},
		{1, -1}, {1, 0}, {1, 1},
	}

	// Count adjacent @ symbols for a position
	countNeighbors := func(r, c int) int {
		count := 0
		for _, d := range directions {
			nr, nc := r+d[0], c+d[1]
			// Check bounds
			if nr >= 0 && nr < rows && nc >= 0 && nc < cols {
				if grid[nr][nc] == '@' {
					count++
				}
			}
		}
		return count
	}

	accessible := 0

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			// Only check positions with paper rolls
			if grid[r][c] == '@' {
				neighbors := countNeighbors(r, c)
				// Accessible if fewer than 4 neighbors
				if neighbors < 4 {
					accessible++
				}
			}
		}
	}

	fmt.Println("Accessible rolls of paper:", accessible)
}
