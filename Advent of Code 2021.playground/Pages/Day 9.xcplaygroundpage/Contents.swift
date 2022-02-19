import Foundation

let intArray = input().lines().map { $0.map { $0.wholeNumberValue! } }

let heightmap = Matrix(rows: intArray)

var lowPoints: [Vec2] = []
var riskLevelSum = 0

// idk how to make Matrix conform to something that is iterable :(
for y in heightmap.rows.indices {
    for (x, height) in heightmap.rows[y].enumerated() {
        if heightmap.neighborValues(of: Vec2(x, y)).allSatisfy({ height < $0 }) {
            riskLevelSum += 1 + height
            lowPoints.append(Vec2(x, y))
        }
    }
}

print(riskLevelSum)


// Part Two

func crawlBasin(lowPoint: Vec2) -> Set<Vec2> {
    var toCrawl: Set<Vec2> = [lowPoint]
    var basin: Set<Vec2> = []

    while let coord = toCrawl.popFirst() {
        basin.insert(coord)
        heightmap.neighbors(of: coord)
            .filter { heightmap.element(at: $0)! < 9 && !basin.contains($0) }
            .forEach { toCrawl.insert($0) }
    }

    return basin
}

let basinSizes = lowPoints.map { crawlBasin(lowPoint: $0).count }
print(basinSizes.sorted().suffix(3).reduce(1, *))

func prettyPrintBasins() {
    let ascii = ["@", ".", ":", "-", "=", "+", "*", "#", "%", " "]
    
    let asciiMap = heightmap.rows.map { $0.map { ascii[$0] } }
    
    for row in asciiMap {
        print(row.joined())
    }
}

