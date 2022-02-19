import Foundation

public struct Vec2: Equatable, Hashable {
    public var x, y: Int
    
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    public func with(x: Int? = nil, y: Int? = nil) -> Vec2 {
        .init(x ?? self.x, y ?? self.y)
    }
}

