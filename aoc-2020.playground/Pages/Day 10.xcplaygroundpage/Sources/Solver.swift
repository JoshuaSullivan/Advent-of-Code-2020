import Foundation

public struct Solver {
    public static func solveFirst(input: [Int]) -> Int {
        let sorted = ([0] + input).sorted()
        let histogram = zip(sorted, sorted.dropFirst())
            .reduce(into: [0, 0, 0]) {
                $0[$1.1 - $1.0 - 1] += 1
            }
        return histogram[0] * (histogram[2] + 1)
    }

    public static func solveSecond(input: [Int]) -> UInt {
        let sorted = input.sorted()
        let complete = [0] + sorted + [sorted.last! + 3]
        print(complete)
        var total: UInt = 1
        for (index, num) in complete.dropLast().enumerated() {
            let start = index + 1
            let end = min(index + 4, complete.count)
            print("*** \(index)")
            print("start:", start, "end:", end)
            let branches = (start..<end).reduce(0) { $0 + ((complete[$1] - num) <= 3 ? 1 : 0) }
            print("branches:", branches)
            total *= UInt(branches)
            print("total:", total)
        }
        return total
    }
}
