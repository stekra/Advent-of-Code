import Foundation

let crabs = input().dropLast().split(separator: ",").map { Int($0)! }

func singleFuelCost(from x: Int, to y: Int) -> Int {
    return abs(x - y) * (abs(x - y) + 1) / 2
//    return abs(x - y)
}

func totalFuelCost(at position: Int) -> Int {
    crabs.reduce(0) { $0 + singleFuelCost(from: $1, to: position) }
}

let average = (crabs.count - 1) / 2
var currentIndex = average
var cheapestSoFar = totalFuelCost(at: currentIndex)

// Ascending
while true {
    currentIndex += 1
    let checkCost = totalFuelCost(at: currentIndex)

    if checkCost < cheapestSoFar {
        cheapestSoFar = checkCost
    } else {
        break
    }
}

// Descending
currentIndex = average
while true {
    currentIndex -= 1
    let checkCost = totalFuelCost(at: currentIndex)

    if checkCost < cheapestSoFar {
        cheapestSoFar = checkCost
    } else {
        break
    }
}

print(cheapestSoFar)
