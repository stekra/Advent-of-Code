import Foundation

struct Board {
    var numbers = [[(number: 0, marked: false)]]
    
    init(outOf boardString: String) {
        self.numbers = boardString.split(separator: "\n").map { boardLine in
            boardLine.split(separator: " ").map { (Int($0)!, false) }
        }
    }
    
    mutating func call(_ number: Int) {
        if let rowIndex = numbers.firstIndex(where: { $0.contains { $0.number == number } }) {
            let elementIndex = numbers[rowIndex].firstIndex { $0.number == number }
            numbers[rowIndex][elementIndex!].marked = true
        }
    }
    
    func checkBingo() -> Bool {
        //horizontal
        for line in numbers {
            if line.allSatisfy({ $0.marked }) {
                return true
            }
        }
        //vertical
        for column in numbers[0].indices {
            for row in numbers.indices {
                if numbers[row][column].marked == false {
                    break
                }
                if (row == numbers.count - 1) {
                    return true
                }
            }
        }
        return false
    }
    
    func getUnmarked() -> [Int] {
        var array: [Int] = []
        
        for row in numbers {
            for number in row {
                guard !number.marked else { continue }
                array.append(number.number)
            }
        }
        
        return array
    }
}

let boardStrings = input()
    .components(separatedBy: "\n\n")
    .dropFirst()

var boards = boardStrings.map { Board(outOf: $0) }

let calls = input()
    .split(separator: "\n")
    .first!
    .split(separator: ",")
    .map { Int($0)! }


var currentBoards = boards
var winningScores: [Int] = []

for number in calls {
    for i in currentBoards.indices {
        currentBoards[i].call(number)
        if currentBoards[i].checkBingo() {
            winningScores.append(number * currentBoards[i].getUnmarked().reduce(0, +))
        }
    }
    
    currentBoards.removeAll { $0.checkBingo() }
}

print(winningScores.first!)
print(winningScores.last!)
