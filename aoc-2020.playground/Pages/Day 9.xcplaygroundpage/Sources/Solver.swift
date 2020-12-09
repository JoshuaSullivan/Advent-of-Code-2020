import Foundation

public struct Solver {
    public static func solveFirst(input: [Int], preambleSize: Int) -> Int {
        input
            .slidingWindows(ofCount: preambleSize + 1)
            .first(where: isInvalid)!
            .last!
    }

    private static func isInvalid(window: Array<Int>.SubSequence) -> Bool {
        let target = window.last!
        return window
            .dropLast()
            .combinations(ofCount: 2)
            .first(where: { $0.reduce(0, +) == target }) == nil
    }
}
