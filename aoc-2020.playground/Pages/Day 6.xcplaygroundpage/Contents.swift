//: # Advent of Code 2020
//: ### Day 6: Custom Customs
//: [Prev](@prev) <---> [Next](@next)

import Foundation

guard let input = try? DataParser<String>().parseDoubleNewlineGroupsOfLines(fileName: "input") else {
    fatalError("Could not read input.")
}

print("First: \(Solver.solveFirst(input: input))")
print("Second: \(Solver.solveSecond(input: input))")

