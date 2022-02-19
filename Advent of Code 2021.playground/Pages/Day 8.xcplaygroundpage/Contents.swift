import Foundation

//digit seg count distribution:
//2: 1
//3: 7
//4: 4
//5: 2,3,5
//6: 0,6,9
//7: 8

let startingTime = Date()

let entries = input()
    .split(separator: "\n")
    .map {
        $0.components(separatedBy: " | ")
            .flatMap { $0.split(separator: " ") }
    }

enum Intermediate {
    case raw(Substring)
    case resolved(Int)
}

var outputValueSum = 0

for line in entries {
    var uniqueSegments: Set<Character> = []
    var oneSegments: Set<Character> = []
    
    //uniques
    let uniquesSolved = line.map { (pattern) -> Intermediate in
        switch pattern.count {
        case 2:
            uniqueSegments.formUnion(pattern)
            oneSegments.formUnion(pattern)
            return .resolved(1)
        case 3:
            uniqueSegments.formUnion(pattern)
            return .resolved(7)
        case 4:
            uniqueSegments.formUnion(pattern)
            return .resolved(4)
        case 7:
            return .resolved(8)
        default:
            return .raw(pattern)
        }
    }
    
    //disambiguate
    let decodedLine = uniquesSolved.map { (intermediate) -> Int in
        switch intermediate {
        case .raw(let pattern):
            let segCount = pattern.count
            
            //0, 6, 9
            if segCount == 6 {
                if uniqueSegments.intersection(pattern).count == 5 {
                    return 9
                } else if oneSegments.intersection(pattern).count == 1 {
                    return 6
                } else {
                    return 0
                }
                
            //2, 3, 5
            } else /* segCount == 5 */ {
                if uniqueSegments.intersection(pattern).count == 3 {
                    return 2
                } else if oneSegments.intersection(pattern).count == 2 {
                    return 3
                } else {
                    return 5
                }
            }
        case .resolved(let value):
            return value
        }
    }
        
    outputValueSum += decodedLine
        .suffix(4)
        .reduce(0) { $0 * 10 + $1 }
}

print(outputValueSum)

print("\(-startingTime.timeIntervalSinceNow) seconds elapsed")
