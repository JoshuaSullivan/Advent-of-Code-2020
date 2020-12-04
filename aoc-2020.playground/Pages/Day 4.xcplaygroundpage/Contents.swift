//: # Advent of Code 2020
//: ### Day 4: Passport Processing
//: [Prev](@prev) <---> [Next](@next)

import Foundation

guard let passports = try? DataParser<Passport>().parseDoubleNewlineWithSpaces(fileName: "testInput") else {
    fatalError("Couldn't read input.")
}

print("Found \(passports.count) passports.")
print("Valid passports: \(Solver.solveFirst(input: passports))")
