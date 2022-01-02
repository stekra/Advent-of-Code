import Foundation

let values = input().split(separator: "\n").map { Int($0)! }

//--- Part One ---

let drops = zip(values, values.dropFirst())
    .lazy
    .filter(<)
    .count

print(drops)


//--- Part Two ---

var windowDrops = 0

for i in 3..<values.count {
    let window = values[i] + values[i-1] + values[i-2]
    let prevWindow = values[i-1] + values[i-2] + values[i-3]
    if (window > prevWindow) {
        windowDrops += 1
    }
}

let windowDrop2 = zip(values, values.dropFirst(3))
    .lazy
    .filter(<)
    .count

print(windowDrops)
print(windowDrop2)
