import Foundation

public func input(filename: String = "input") -> String {
    let url = URL(fileURLWithPath: Bundle.main.path(forResource: filename, ofType: "txt")!)
    let rawInput = try! Data(contentsOf: url)
    return String(data: rawInput, encoding: .utf8)!
}
