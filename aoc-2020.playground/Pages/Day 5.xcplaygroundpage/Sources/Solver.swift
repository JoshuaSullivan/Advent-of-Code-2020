import Foundation

extension String {
    var asBinary: Int {
        strtol(self, nil, 2) // Thanks, cstdlib!
    }
}

public struct BoardingPass: StringInitable, Comparable {
    let string: String

    public init?(_ string: String) {
        self.string = string
    }

    public var row: Int {
        string
            .prefix(7)
            .map { $0 == "F" ? "0" : "1" }
            .joined()
            .asBinary
    }

    public var col: Int {
        string
            .suffix(3)
            .map { $0 == "L" ? "0" : "1" }
            .joined()
            .asBinary
    }

    var seatId: Int {
        return row * 8 + col
    }

    public static func < (lhs: BoardingPass, rhs: BoardingPass) -> Bool { lhs.seatId < rhs.seatId }
}

public struct Solver {
    public static func solveFirst(_ input: [BoardingPass]) -> Int {
        return input.map(\.seatId).max()!
    }

    public static func solveSecond(_ input: [BoardingPass]) -> Int {
        let passes = input.sorted()
        let result: Int = zip(passes, passes.dropFirst())
            .filter { $0.seatId + 1 < $1.seatId }
            .map { $0.0.seatId + 1 }
            .first!
        return result
    }
}
