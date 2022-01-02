import Foundation

//digit seg count distribution:
//2: 1
//3: 7
//4: 4
//5: 2,3,5
//6: 0,6,9
//7: 8

let entries = input()
    .split(separator: "\n")
    .map {
        $0.components(separatedBy: " | ")
            .flatMap { $0.split(separator: " ") }
    }

extension String {
    mutating func add(_ chars: String) {
        for c in chars {
            if !self.contains(c) { self += "\(c)" }
        }
    }
}

extension StringProtocol {
    func commonCharacters<S: StringProtocol>(with other: S) -> Int {
        let intersection = Set(self).intersection(other)
        return intersection.count
    }
}

var outputValueSum = 0

for line in entries {
    var uniqueSegments = ""
    var oneSegments = ""
    
    //uniques
    let uniquesSolved = line.map { (pattern) -> Any in
        switch pattern.count {
        case 2:
            uniqueSegments.add(String(pattern))
            oneSegments.add(String(pattern))
            return 1
        case 3:
            uniqueSegments.add(String(pattern))
            return 7
        case 4:
            uniqueSegments.add(String(pattern))
            return 4
        case 7:
            return 8
        default:
            return pattern
        }
    }
    
    //disambiguate
    let decodedLine = uniquesSolved.map { (pattern) -> Int in
        if let string = pattern as? Substring {
            let segCount = string.count
            
            //0, 6, 9
            if segCount == 6 {
                if string.commonCharacters(with: uniqueSegments) == 5 {
                    return 9
                } else if string.commonCharacters(with: oneSegments) == 1 {
                    return 6
                } else {
                    return 0
                }
                
            //2, 3, 5
            } else /* segCount == 5 */ {
                if string.commonCharacters(with: uniqueSegments) == 3 {
                    return 2
                } else if string.commonCharacters(with: oneSegments) == 2 {
                    return 3
                } else {
                    return 5
                }
                
            }
        } else {
            return pattern as! Int
        }
    }
        
    outputValueSum += decodedLine
        .suffix(4)
        .reduce(0) { $0 * 10 + $1 }
}

print(outputValueSum)
