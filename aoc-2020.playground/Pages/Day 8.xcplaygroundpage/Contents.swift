//: # Advent of Code 2020
//: ### Day 8: Handheld Halting
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let input = try! DataParser<Instruction>().parseLines(fileName: "input")

print("First: \(Solver.solveFirst(input: input))")
print("Second: \(Solver.solveSecond(input: input))")
