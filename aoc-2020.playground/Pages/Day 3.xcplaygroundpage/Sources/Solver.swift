import Foundation

public struct TreeRow: StringInitable {

    let pattern: [Character]

    func isTree(at pos: Int) -> Bool {
        return pattern[pos % pattern.count] == "#"
    }

    public init?(_ string: String) {
        pattern = string.map { $0 }
    }
}

public struct Solver {
    public static func solveFirst(input: [TreeRow]) -> Int {
        solve(input: input, right: 3, down: 1)
    }

    public static func solveSecond(input: [TreeRow]) -> Int {
        let slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
        return slopes
            .map { solve(input: input, right: $0[0], down: $0[1]) }
            .reduce(1, *)
    }

    private static func solve(input: [TreeRow], right: Int, down: Int) -> Int {
        return (0..<input.count).reduce(0) { result, index in
            guard index % down == 0 else { return result }
            return result + (input[index].isTree(at: index * right) ? 1 : 0)
        }
    }
}
