import Foundation

public struct Solver {

    private static let allLetters = Set<Character>("abcdefghijklmnopqrstuvwxyz")

    public static func solveFirst(input: [[String]]) -> Int {
        input
            .map { Set<Character>($0.joined()) }
            .map(\.count)
            .reduce(0, +)
    }

    public static func solveSecond(input: [[String]]) -> Int {
        input.map { group -> Set<Character> in
            group
                .map(Set.init)
                .reduce(allLetters) { $0.intersection($1) }
        }
        .map(\.count)
        .reduce(0, +)
    }
}
