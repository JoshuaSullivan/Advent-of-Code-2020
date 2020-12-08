import Foundation

public struct Instruction: StringInitable {
    enum Op: String {
        case acc, jmp, nop
    }

    var op: Op
    let val: Int

    public init?(_ string: String) {
        let parts = string.split(separator: " ")
        op = Op(rawValue: String(parts[0]))!
        let isNegative = parts[1].first! == "-"
        val = Int(parts[1].dropFirst())! * (isNegative ? -1 : 1)
    }
}

private class HandheldGame {

    enum RunResult {
        case encouteredLoop
        case completed
    }

    var visitedIndices: [Int : Bool] = [:]
    var index = 0
    var accumulator = 0

    func run(input: [Instruction], swappingIndex: Int? = nil) -> RunResult {
        visitedIndices = [:]
        index = 0
        accumulator = 0

        while(!visitedIndices[index, default: false] && index < input.count) {
            visitedIndices[index] = true
            var inst = input[index]
            if index == swappingIndex {
                if inst.op == .jmp {
                    inst.op = .nop
                } else if inst.op == .nop {
                    inst.op = .jmp
                }
            }
            switch inst.op {
            case .acc:
                accumulator += inst.val
                index += 1
            case .jmp:
                index += inst.val
            case .nop:
                index += 1
            }
        }
        if index >= input.count {
            return .completed
        } else {
            return .encouteredLoop
        }
    }
}

public struct Solver {
    public static func solveFirst(input: [Instruction]) -> Int {
        let handheld = HandheldGame()
        let _ = handheld.run(input: input)
        return handheld.accumulator
    }

    public static func solveSecond(input: [Instruction]) -> Int {
        let swapCandidates = input
            .enumerated()
            .filter { $1.op != .acc }
            .map { $0.offset }
        let handheld = HandheldGame()
        let _ = swapCandidates.first {
            handheld.run(input: input, swappingIndex: $0) == .completed
        }
        return handheld.accumulator
    }
}
