import Foundation

let values: [(command: Command, amount: Int)] = input()
    .split(separator: "\n")
    .map { $0.split(separator: " ") }
    .map { (Command(rawValue: String($0[0]))!, Int($0[1])!) }

enum Command: String { case forward, down, up }

//--- Part One ---

let moves = [Command: Int](values, uniquingKeysWith: +)

print(moves[.forward]! * (moves[.down]! - moves[.up]!))


//--- Part Two ---

var horizontal = 0
var depth = 0
var aim = 0

for (command, amount) in values {
    switch command {
    case .down:
        aim += amount
    case .up:
        aim -= amount
    case .forward:
        horizontal += amount
        depth += aim * amount
    }
}

print(horizontal * depth)
