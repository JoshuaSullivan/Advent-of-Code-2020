//: # Advent of Code 2020
//: ### Day 1: Report Repair
//: [Next](@next)

import Foundation

guard let input = try? DataParser<Int>().parseLines(fileName: "input") else {
    fatalError("Could not read input.")
}

print("First: \(Solver.solve(input: input, using: 2))")
print("Second: \(Solver.solve(input: input, using: 3))")
