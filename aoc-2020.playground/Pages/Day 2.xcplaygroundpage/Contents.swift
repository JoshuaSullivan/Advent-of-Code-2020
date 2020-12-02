//: # Advent of Code 2020
//: ### Day 2: Password Philosophy
//: [Prev](@prev) <---> [Next](@next)

import Foundation

guard let input = try? DataParser<PasswordRecord>().parseLines(fileName: "input") else {
    fatalError("Could not read input.")
}

print("First: \(Solver.solveFirst(input: input))")
print("Second: \(Solver.solveSecond(input: input))")
