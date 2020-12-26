import Foundation

private typealias NeighborCounter = (Int, Int, Grid) -> Int

public enum Cell: StringInitable, Equatable {
    case floor
    case empty
    case filled
    
    public init?(_ string: String) {
        switch string {
        case ".": self = .floor
        case "L": self = .empty
        case "#": self = .filled
        default: return nil
        }
    }
    
    public func cell(forNeighbors count: Int, threshold: Int) -> Cell {
        if self == .empty && count == 0 {
            return .filled
        } else if self == .filled && count >= threshold {
            return .empty
        }
        return self
    }
}

private struct Position: Equatable, CustomStringConvertible {
    let x: Int
    let y: Int
    
    var description: String { "(x: \(x), y: \(y)" }
}

private enum UnitVector: Equatable, CaseIterable {
    case tl, tc, tr
    case cl,     cr
    case bl, bc, br
    
    var offset: (Int, Int) {
        switch self {
        case .tl: return ( 1, -1)
        case .tc: return ( 1,  0)
        case .tr: return ( 1,  1)
        case .cl: return ( 0, -1)
        case .cr: return ( 0,  1)
        case .bl: return (-1, -1)
        case .bc: return (-1,  0)
        case .br: return (-1,  1)
        }
    }
    
    func projected(from start: Position, distance: Int) -> Position {
        Position(x: start.x + offset.1 * distance, y: start.y + offset.0 * distance)
    }
}

private struct Grid: Equatable {
    let width: Int
    let height: Int
    let threshold: Int
    
    let cells: [[Cell]]
    
    init(cells: [[Cell]], threshold: Int) {
        width = cells[0].count
        height = cells.count
        self.cells = cells
        self.threshold = threshold
    }
    
    func contains(position: Position) -> Bool {
        return  position.y >= 0 &&  position.y < height &&  position.x >= 0 &&  position.x < width
    }
    
    func evolved(withNeighbors neighbors: NeighborCounter) -> Grid {
        let newCells = (0..<cells.count).map { row in
            (0..<cells[0].count).map { col -> Cell in
                let cell = cells[row][col]
                guard cell != .floor else { return cell }
                return cell.cell(forNeighbors: neighbors(row, col, self), threshold: threshold)
            }
        }
        return Grid(cells: newCells, threshold: threshold)
    }
    
    var filledSeats: Int {
        cells
            .map { $0.filter({ $0 == .filled }).count }
            .reduce(0, +)
    }
}


public struct Solver {
    
    public static func solveFirst(input: [[Cell]]) -> Int {
        var prevGrid = Grid(cells: input, threshold: 4)
        var grid: Grid
        var isComplete = false
        var iteration = 0
        repeat {
            grid = prevGrid.evolved(withNeighbors: filledNeighbors)
            if grid == prevGrid { isComplete = true }
            prevGrid = grid
            iteration += 1
        } while !isComplete && iteration < 1_000
        if iteration >= 1_000 { print("Timed out!") }
        else { print("Found answer in \(iteration) iterations.")}
        return grid.filledSeats
    }
    
    public static func solveSecond(input: [[Cell]]) -> Int {
        var prevGrid = Grid(cells: input, threshold: 5)
        var grid: Grid
        var isComplete = false
        var iteration = 0
        repeat {
            grid = prevGrid.evolved(withNeighbors: visibleOccupiedSeats)
            if grid == prevGrid { isComplete = true }
            prevGrid = grid
            iteration += 1
        } while !isComplete && iteration < 1_000
        if iteration >= 1_000 { print("Timed out!") }
        else { print("Found answer in \(iteration) iterations.")}
        return grid.filledSeats
    }
    
    private static func filledNeighbors(ofRow row: Int, col: Int, in grid: Grid) -> Int {
        let rowMin = max(0, row - 1)
        let rowMax = min(grid.height - 1, row + 1)
        let colMin = max(0, col - 1)
        let colMax = min(grid.width - 1, col + 1)
        return (rowMin...rowMax).reduce(0) { rowResult, y in
            rowResult + (colMin...colMax).reduce(0) { colResult, x in
                guard !(y == row && x == col) else { return colResult }
                return colResult + (grid.cells[y][x] == .filled ? 1 : 0)
            }
        }
    }
    
    private static func visibleOccupiedSeats(atRow row: Int, col: Int, in grid: Grid) -> Int {
        let start = Position(x: col, y: row)
        return UnitVector.allCases.map { uv -> Bool in
            var dist = 1
            while true {
                let pos = uv.projected(from: start, distance: dist)
                guard grid.contains(position: pos) else { return false }
                switch grid.cells[pos.y][pos.x] {
                case .floor: dist += 1
                case .empty: return false
                case .filled: return true
                }
            }
        }
        .filter({ $0 })
        .count
    }
}
