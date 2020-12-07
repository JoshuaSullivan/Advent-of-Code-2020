//: # Advent of Code 2020
//: ### Day 7: Handy Haversacks
//: [Prev](@prev) <---> [Next](@next)

import Foundation

guard let input = try? DataParser<BagRule>().parseLines(fileName: "input") else {
    fatalError("Could not read input.")
}

print("First: \(Solver.solveFirst(input: input, key: "shiny gold"))")
print("Second: \(Solver.solveSecond(input: input, key: "shiny gold"))")
