////
/// CGRectExt.swift
//

//
//  CGRect.swift
//

public extension CGRect {

// MARK: convenience

    init(center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2), size: size)
    }

    init(x: CGFloat, y: CGFloat, right: CGFloat, bottom: CGFloat) {
        self.init(origin: CGPoint(x: x, y: y), size: CGSize(width: right - x, height: bottom - y))
    }

    static func at(x: CGFloat, y: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: 0, height: 0)
    }

// MARK: helpers
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}
