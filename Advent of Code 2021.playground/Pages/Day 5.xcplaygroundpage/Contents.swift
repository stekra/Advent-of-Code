import Foundation

struct Position: Hashable {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    init(fromCommaSeparatedString string: String) {
        x = Int(string.split(separator: ",").first!)!
        y = Int(string.split(separator: ",").last!)!
    }
}

struct Line {
    let start: Position
    let end: Position
    
    func range(_ a: Int, _ b: Int) -> [Int] {
        return a < b ? Array(a...b) : (b...a).reversed()
    }
    
    var positions: [Position] {
        if start.x == end.x {
            return range(start.y, end.y).map { Position(x: start.x, y: $0) }
        } else if start.y == end.y {
            return range(start.x, end.x).map { Position(x: $0, y: start.y) }
        } else {
            return zip(range(start.x, end.x), range(start.y, end.y)).map { Position(x: $0, y: $1) }
//            return []
        }
    }
}

let rows = input().split(separator: "\n")

let lines: [Line] = rows.map {
    let positions = $0
        .components(separatedBy: " -> ")
        .map { Position(fromCommaSeparatedString: $0) }
    return Line(start: positions[0], end: positions[1])
}

var depths: [Position: Int] = [:]

depths = lines.reduce(into: [:]) { counts, line in
    for pos in line.positions {
        counts[pos, default: 0] += 1
    }
}

print(depths.filter { $0.value >= 2 }.count.description )



// ~._,^* ASCII Visualisation *^._,~

func printGrid(depths: [Position : Int], minValue: Int, maxValue: Int) {
    for y in minValue...maxValue {
        for x in minValue...maxValue {
            if let posValue = depths[Position(x: x, y: y)] {
                print(posValue.description, terminator: "")
            } else {
                print(".", terminator: "")
            }
        }
        print("")
    }
}

//printGrid(depths: depths, minValue: 1, maxValue: 999)
