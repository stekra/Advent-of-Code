import Cocoa

let context = CGContext(
    data: nil,
    width: 420, height: 140,
    bitsPerComponent: 8,
    bytesPerRow: 420 * 4,
    space: CGColorSpaceCreateDeviceRGB(),
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
)!

context.setStrokeColor(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor)
context.setLineWidth(2)
context.addLines(between: [
    CGPoint(x: 40, y: 10),
    CGPoint(x: 140, y: 10),
    CGPoint(x: 240, y: 50),
])
//context.strokePath()
context.fillPath()

context.strokeEllipse(in: CGRect(x: 10, y: 10, width: 800, height: 60))

NSImage(cgImage: context.makeImage()!, size: .zero)
