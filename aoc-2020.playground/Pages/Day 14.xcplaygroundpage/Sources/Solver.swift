import Foundation

extension Int {
    func bitString(paddedTo length: Int) -> String {
        var str = String(self, radix: 2)
        while str.count < length { str = "0" + str }
        return str
    }
    
    func bitArray(paddedTo length: Int) -> [String] {
        return bitString(paddedTo: length).map { String($0) }
    }
}

public enum Command: StringInitable, CustomStringConvertible {
    public enum MaskBit: Character {
        case any = "X"
        case zero = "0"
        case one = "1"
        
        public func apply(to bit: String) -> String {
            switch self {
            case .any: return bit
            case .zero: return "0"
            case .one: return "1"
            }
        }
        
        public func applyV2(to bit: String) -> MaskBit {
            switch self {
            case .any: return .any
            case .zero: return bit == "0" ? .zero : .one
            case .one: return .one
            }
        }
    }
    
    case mask([MaskBit])
    case mem(address: Int, value: Int)
    
    public init?(_ string: String) {
        switch string.prefix(3) {
        case "mas":
            let mask = string.dropFirst(7).map { MaskBit(rawValue: $0)! }
            self = .mask(mask)
        case "mem":
            let parts = string.split(separator: "=").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            let address = Int(parts[0].dropFirst(4).dropLast())!
            let value = Int(parts[1])!
            self = .mem(address: address, value: value)
        default:
            return nil
        }
    }
    
    public var description: String {
        switch self {
        case .mask(let mask): return "mask = \(mask.map({ String($0.rawValue) }).joined())"
        case .mem(let address, let value): return "mem[\(address)] = \(value)"
        }
    }
}

public struct Solver {
    public static func solveFirst(program: [Command]) -> Int {
        var activeMask: [Command.MaskBit] = []
        var memory: [Int: Int] = [:]
        for command in program {
            switch command {
            case .mask(let mask):
                activeMask = mask
            case .mem(let address, let value):
                let maskedValue = zip(activeMask, value.bitString(paddedTo: 36))
                    .map { maskBit, binChar in maskBit.apply(to: String(binChar)) }
                memory[address] = Int(maskedValue.joined(), radix: 2)!
            }
        }
        return memory.values.reduce(0, +)
    }
    
    public static func solveSecond(program: [Command]) -> Int {
        var activeMask: [Command.MaskBit] = []
        var memory: [Int: Int] = [:]
        for command in program {
            switch command {
            case .mask(let mask):
                activeMask = mask
            case .mem(let address, let value):
                let maskedAddress = zip(activeMask, address.bitString(paddedTo: 36))
                    .map { maskBit, binChar in maskBit.applyV2(to: String(binChar)) }
                generateAddresses(from: maskedAddress).forEach { memory[$0] = value }
            }
        }
        return memory.values.reduce(0, +)
    }
    
    private static  func generateAddresses(from address: [Command.MaskBit]) -> [Int] {
        let bitCount: Int = address.filter { $0 == .any }.count
        let intCount: Int = 1 << bitCount
        return (0..<intCount).map { floatBitsInt in
            let floatBits = floatBitsInt.bitArray(paddedTo: bitCount)
            var floatIndex = 0
            let mappedBits = address.reduce("") { result, bit in
                var newBit: String
                switch bit {
                case .any:
                    newBit = floatBits[floatIndex]
                    floatIndex += 1
                case .zero:
                    newBit = "0"
                case .one:
                    newBit = "1"
                }
                return result.appending(newBit)
            }
            return Int(mappedBits, radix: 2)!
        }
    }
}
