import Foundation

let values = input()
    .split(separator: "\n")
    .map { $0.map { $0.wholeNumberValue == 1 } }

extension Sequence where Element: Hashable {
    public func mostCommonElement() -> Element? {
        let counts = self.reduce(into: [:]) {
            $0[$1, default: 0] += 1
        }
        
        return counts.max { $0.value < $1.value }?.key
    }
}

extension Sequence where Element == Bool {
    func decimal() -> Int? {
        var string = ""
        for x in self {
            string.append(x ? "1" : "0")
        }
        return Int(string, radix: 2)
    }
}

//--- Part One ---

let columns = values.first!.indices.map { i in values.map{ $0[i] } }

var gamma: [Bool] = []
var epsilon: [Bool] = []

for column in columns {
    gamma.append(column.mostCommonElement()!)
    epsilon.append(!column.mostCommonElement()!)  //!this is cute!
}

print(gamma.decimal()! * epsilon.decimal()!)


//--- Part Two ---

var o2 = values
var index = 0

while o2.count > 1 {
    let count = o2.reduce(into: (zeroes: 0, ones: 0)) { count, bits in
        if bits[index] {
            count.ones += 1
        } else {
            count.zeroes += 1
        }
    }
    
    o2.removeAll() {
        var o2criterion: Bool {
            if count.ones == count.zeroes {
                return true
            } else {
                return count.ones > count.zeroes
            }
        }
        return $0[index] != o2criterion
    }
    
    index += 1
}

var co2 = values
index = 0

while co2.count > 1 {
    let count = co2.reduce(into: (zeroes: 0, ones: 0)) { count, bits in
        if bits[index] {
            count.ones += 1
        } else {
            count.zeroes += 1
        }
    }
    
    co2.removeAll() {
        var co2criterion: Bool {
            if count.ones == count.zeroes {
                return false
            } else {
                return count.ones < count.zeroes
            }
        }
        return $0[index] != co2criterion
    }
    
    index += 1
}

print(o2[0].decimal()! * co2[0].decimal()!)





//This is so complicated
let str = "ABCD"
let strindex = str.index(str.startIndex, offsetBy: 3)
str[strindex]

