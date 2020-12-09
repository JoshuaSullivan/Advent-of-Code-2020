//: # Advent of Code 2020
//: ### Day 9: Encoding Error
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try! DataParser<Int>().parseLines(fileName: "input")

print("First: \(Solver.solveFirst(input: input, preambleSize: 25))")

