//: # Advent of Code 2020
//: ### Day 5: Binary Boarding
//: [Prev](@prev) <---> [Next](@next)

import Foundation

guard let input = try? DataParser<BoardingPass>().parseLines(fileName: "input") else {
    fatalError("Could not read input.")
}

print("First: \(Solver.solveFirst(input))")
let secondId = Solver.solveSecond(input)
