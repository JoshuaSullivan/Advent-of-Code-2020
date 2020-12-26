import Foundation

public struct Movement: StringInitable, CustomStringConvertible {
    public enum Command: String {
        case n = "N"
        case s = "S"
        case e = "E"
        case w = "W"
        case l = "L"
        case r = "R"
        case f = "F"
    }
    
    public let command: Command
    public let value: Int
    
    public init?(_ string: String) {
        guard
            let rawCom = string.first,
            let com = Command(rawValue: String(rawCom)),
            let val = Int(string.dropFirst())
        else { return nil }

        command = com
        value = val
    }
    
    public var description: String {
        "Movement[\(command.rawValue) \(value)]"
    }
}

enum Heading: CaseIterable {
    case e, s, w, n
    
    func applying(movement: Movement) -> Heading {
        let r = Heading.allCases.firstIndex(of: self)!
        let v = movement.value / 90
        let rNew: Int
        switch movement.command {
        case .r: rNew = (r + v) % 4
        case .l: rNew = (r + (4 - v)) % 4
        default: return self
        }
        return Heading.allCases[rNew]
    }
    
    var vector: (Int, Int) {
        switch self {
        case .e: return ( 1,  0)
        case .s: return ( 0, -1)
        case .w: return (-1,  0)
        case .n: return ( 0,  1)
        }
    }
}

let degToRad: Double = Double.pi / 180.0

struct Waypoint: CustomStringConvertible {
    
    let x: Int
    let y: Int
    
    func applying(movement: Movement) -> Waypoint {
        switch movement.command {
        case .n: return Waypoint(x: x, y: y + movement.value)
        case .s: return Waypoint(x: x, y: y - movement.value)
        case .e: return Waypoint(x: x + movement.value, y: y)
        case .w: return Waypoint(x: x - movement.value, y: y)
        case .r:
            switch movement.value {
            case 90: return Waypoint(x: y, y: -x)
            case 180: return Waypoint(x: -x, y: -y)
            case 270: return Waypoint(x: -y, y: x)
            default: return self
            }
        case .l:
            switch movement.value {
            case 90: return Waypoint(x: -y, y: x)
            case 180: return Waypoint(x: -x, y: -y)
            case 270: return Waypoint(x: y, y: -x)
            default: return self
            }
        case .f: return self
        }
    }
    
    var description: String { "(x: \(x), y: \(y))" }
}

struct Position {
    let x: Int
    let y: Int
    
    func moving(distance: Int, heading: Heading) -> Position {
        let vec = heading.vector
        return Position(
            x: x + vec.0 * distance,
            y: y + vec.1 * distance
        )
    }
    
    func applying(waypoint: Waypoint, times: Int) -> Position {
        Position(x: x + waypoint.x * times, y: y + waypoint.y * times)
    }
    
    var distance: Int {
        return abs(x) + abs(y)
    }
}

public struct Solver {
    public static func solveFirst(input: [Movement]) -> Int {
        var position = Position(x: 0, y: 0)
        var heading = Heading.e
        for move in input {
            switch move.command {
            case .n: position = position.moving(distance: move.value, heading: .n)
            case .s: position = position.moving(distance: move.value, heading: .s)
            case .e: position = position.moving(distance: move.value, heading: .e)
            case .w: position = position.moving(distance: move.value, heading: .w)
            case .l: heading = heading.applying(movement: move)
            case .r: heading = heading.applying(movement: move)
            case .f: position = position.moving(distance: move.value, heading: heading)
            }
        }
        return position.distance
    }
    
    public static func solveSecond(input: [Movement]) -> Int {
        var position = Position(x: 0, y: 0)
        var waypoint = Waypoint(x: 10, y: 1)
        for move in input {
            print(move)
            if move.command == .f {
                position = position.applying(waypoint: waypoint, times: move.value)
                print("Position: \(position)")
            } else {
                waypoint = waypoint.applying(movement: move)
                print("Waypoint: \(waypoint)")
            }
        }
        return position.distance
    }
}
