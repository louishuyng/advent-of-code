package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	var grid [][]byte

	// Read from input file
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
			grid = append(grid, []byte(line))
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

	// Part 1: count initially accessible
	part1 := 0
	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if grid[r][c] == '@' {
				if countNeighbors(r, c) < 4 {
					part1++
				}
			}
		}
	}
	fmt.Println("Part 1:", part1)

	// Part 2: simulate removal until none accessible
	totalRemoved := 0

	for {
		// Find all currently accessible rolls
		var toRemove [][2]int
		for r := 0; r < rows; r++ {
			for c := 0; c < cols; c++ {
				if grid[r][c] == '@' {
					if countNeighbors(r, c) < 4 {
						toRemove = append(toRemove, [2]int{r, c})
					}
				}
			}
		}

		// If none accessible, we're done
		if len(toRemove) == 0 {
			break
		}

		// Remove all accessible rolls
		for _, pos := range toRemove {
			grid[pos[0]][pos[1]] = '.'
		}
		totalRemoved += len(toRemove)
	}

	fmt.Println("Part 2:", totalRemoved)
}
