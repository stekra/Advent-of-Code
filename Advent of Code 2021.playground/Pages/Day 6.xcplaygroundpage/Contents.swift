import Foundation

let fishies = input().dropLast().split(separator: ",").map { Int($0)! }

var ages = (0...8).map { age in
    fishies.filter { $0 == age }.count
}

let days = 256

for _ in 0..<days {
    let reproducing = ages[0]
    ages.removeFirst()
    ages[6] += reproducing
    ages.append(reproducing)
}

print(ages.reduce(0, +))
