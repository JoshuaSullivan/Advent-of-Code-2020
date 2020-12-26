//: # Advent of Code 2020
//: ### Day 13: Shuttle Search
//: [Prev](@prev) <---> [Next](@next)

import Foundation

let startTime = 1000303
let input = try! DataParser<Int>()
    .parseCSV(fileName: "input")
    .enumerated()
    .compactMap { (index: Int, value: Int) -> Bus? in
        guard value > 0 else { return nil }
        return Bus(id: value, offset: index)
    }
print(input)
print("First: \(Solver.solveFirst(startTime: startTime, buses: input))")

let testInput = try! DataParser<Int>()
    .parseCSV(fileName: "testInput")
    .enumerated()
    .compactMap { (index: Int, value: Int) -> Bus? in
        guard value > 0 else { return nil }
        return Bus(id: value, offset: index)
    }

print(testInput)

let testResult = testInput.dropFirst().reduce(testInput.first!.id) { result, bus in
    guard let multiple = (1...10_000).first(where: { ($0 * result - bus.id) % bus.id == 0 }) else {
        fatalError("Could not find multiple for \(bus) satisfying conditions.")
    }
    print(bus, ":", multiple)
    return result * multiple
}
print(testResult)
