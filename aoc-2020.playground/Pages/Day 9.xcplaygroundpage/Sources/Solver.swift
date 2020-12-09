import Foundation

public struct Solver {
    public static func solveFirst(input: [Int], preambleSize: Int) -> Int {
        input
            .slidingWindows(ofCount: preambleSize + 1)
            .first(where: isInvalid)!
            .last!
    }

    public static func solveSecond(input: [Int], target: Int) -> Int {
        for size in (2..<input.count) {
            for window in input.slidingWindows(ofCount: size) {
                if window.reduce(0, +) == target {
                    return window.min()! + window.max()!
                }
            }
        }
        fatalError("Unable to find a solution.")
    }

    private static func isInvalid(window: Array<Int>.SubSequence) -> Bool {
        let target = window.last!
        return window
            .dropLast()
            .combinations(ofCount: 2)
            .first(where: { $0.reduce(0, +) == target }) == nil
    }
}
