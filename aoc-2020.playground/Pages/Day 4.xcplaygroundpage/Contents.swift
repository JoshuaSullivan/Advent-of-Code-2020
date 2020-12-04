//: # Advent of Code 2020
//: ### Day 4: Passport Processing
//: [Prev](@prev) <---> [Next](@next)

import Foundation

guard let passports = try? DataParser<Passport>().parseDoubleNewlineWithSpaces(fileName: "input") else {
    fatalError("Couldn't read input.")
}

print("First: \(Solver.solveFirst(input: passports))")
print("Second: \(Solver.solveSecond(input: passports))")
