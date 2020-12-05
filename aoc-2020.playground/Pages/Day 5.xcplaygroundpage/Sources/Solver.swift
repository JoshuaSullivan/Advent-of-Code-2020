import Foundation

extension String {
    var asBinary: Int {
        strtol(self, nil, 2) // Thanks, cstdlib!
    }
}

public struct BoardingPass: StringInitable, Comparable {
    let seatId: Int

    public init?(_ string: String) {
        seatId = string
            .map { ($0 == "F" || $0 == "L") ? "0" : "1" }
            .joined()
            .asBinary
    }

    public var row: Int {
        (seatId & (0x7FFF << 3)) >> 3
    }

    public var col: Int {
        seatId & 0x7
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
