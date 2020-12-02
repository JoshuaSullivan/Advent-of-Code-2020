import Foundation

public struct Solver {
    public static func solveFirst(input: [PasswordRecord]) -> Int {
        return input
            .filter { $0.isValid }
            .count
    }

    public static func solveSecond(input: [PasswordRecord]) -> Int {
        return input
            .filter { $0.isValidAltRule }
            .count
    }
}
