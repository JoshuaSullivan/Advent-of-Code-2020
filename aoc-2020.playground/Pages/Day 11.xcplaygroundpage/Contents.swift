//: # Advent of Code 2020
//: ### Day 11: Seating System
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try! DataParser<Cell>().parseLinesOfCharacters(fileName: "input")

//print("Grid dimension: \(input[0].count)x\(input.count)")
//print("First: \(Solver.solveFirst(input: input))")
print("Second: \(Solver.solveSecond(input: input))")
