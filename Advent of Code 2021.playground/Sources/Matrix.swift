import Foundation

public struct Matrix<Element> {
    public var rows: [[Element]]
    
    public init(rows array: [[Element]]) {
        self.rows = array
    }
    
    public func isInMatrix(_ position: Vec2) -> Bool {
        if (0..<rows[0].count).contains(position.x)
            && (0..<rows.count).contains(position.y) {
            return true
        } else {
            return false
        }
    }
    
    public func element(at position: Vec2) -> Element? {
        guard isInMatrix(position) else { return nil }
        return rows[position.y][position.x]
    }
    
    public func neighbors(of position: Vec2) -> [Vec2] {
        guard isInMatrix(position) else { return [] }
        
        return [
            position.with(y: position.y - 1),
            position.with(y: position.y + 1),
            position.with(x: position.x - 1),
            position.with(x: position.x + 1),
        ].filter { isInMatrix($0) }
    }
    
    public func neighborValues(of position: Vec2) -> [Element] {
        guard isInMatrix(position) else { return [] }
        
        return neighbors(of: position).map {
            element(at: $0)!
        }
    }
}
