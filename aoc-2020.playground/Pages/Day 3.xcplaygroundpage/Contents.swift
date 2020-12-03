//: # Advent of Code 2020
//: ### Day 3: Toboggan Trajectory
//: [Prev](@prev) <---> [Next](@next)

import Foundation

guard let input = try? DataParser<TreeRow>().parseLines(fileName: "input") else {
    fatalError("Couldn't load input.")
}

print("First: \(Solver.solveFirst(input: input))")
print("Second: \(Solver.solveSecond(input: input))")

