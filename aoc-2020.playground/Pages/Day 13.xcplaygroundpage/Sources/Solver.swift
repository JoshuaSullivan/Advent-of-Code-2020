import Foundation

public struct Bus: CustomStringConvertible {
    
    public static let zero = Bus(id: 0, offset: 0)
    
    public let id: Int
    public let offset: Int
    
    public init(id: Int, offset: Int) {
        self.id = id
        self.offset = offset
    }
        
    public var description: String {
        "\(id) (\(offset))"
    }
}

public struct Solver {
    public static func solveFirst(startTime: Int, buses: [Bus]) -> Int {
        let waitTime = buses.map { bus -> Int in
            let nextCycle = Int(ceil(Double(startTime) / Double(bus.id)))
            return nextCycle * bus.id - startTime
        }
        let min = waitTime.min()!
        let minIndex = waitTime.firstIndex(of: min)!
        return min * buses[minIndex].id
    }
    
    public static func solveSecond(input: [Bus]) -> Int {
        return 0
    }
}
