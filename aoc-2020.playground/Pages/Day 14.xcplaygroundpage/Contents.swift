//: # Advent of Code 2020
//: ### Day 14: Docking Data
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let program = try! DataParser<Command>().parseLines(fileName: "input")

print("First:", Solver.solveFirst(program: program))

print("Second:", Solver.solveSecond(program: program))
