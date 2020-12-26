//: # Advent of Code 2020
//: ### Day 12: Rain Risk
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try! DataParser<Movement>().parseLines(fileName: "input")

print("First: \(Solver.solveFirst(input: input))")
print("Second: \(Solver.solveSecond(input: input))")
