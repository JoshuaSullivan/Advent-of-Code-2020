import Foundation

// No longer needed, but kept for future reference.

//extension String {
//    var asBinary: Int {
//        strtol(self, nil, 2) // Thanks, cstdlib!
//    }
//}

public struct BoardingPass: StringInitable, Comparable {
    let seatId: Int

    public init?(_ string: String) {
        // 1. Iterate through the characters of the input string with reduce.
        // 2. For each character, determine if it's a 0 or a 1 (F & L = 0, B & R = 1)
        // 3. Take whatever previous value we had and bit-shift it one to the left to "make room".
        // 4. Insert the new 0 or 1 in the right-most bit using bitwise OR.

        seatId = string.reduce(0) { ($0 << 1) | (($1 == "F" || $1 == "L") ? 0 : 1) }
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
