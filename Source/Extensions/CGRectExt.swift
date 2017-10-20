////
/// CGRectExt.swift
//

//
//  CGRect.swift
//

public extension CGRect {

// MARK: convenience

    init(x: CGFloat, y: CGFloat, right: CGFloat, bottom: CGFloat) {
        origin = CGPoint(x: x, y: y)
        size = CGSize(width: right - x, height: bottom - y)
    }

    static func at(x: CGFloat, y: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: 0, height: 0)
    }

// MARK: helpers
    var x: CGFloat { return self.origin.x }
    var y: CGFloat { return self.origin.y }
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }

// MARK: dimension setters
    func atOrigin(_ amt: CGPoint) -> CGRect {
        var f = self
        f.origin = amt
        return f
    }

    func withSize(_ amt: CGSize) -> CGRect {
        var f = self
        f.size = amt
        return f
    }

    func atX(_ amt: CGFloat) -> CGRect {
        var f = self
        f.origin.x = amt
        return f
    }

    func atY(_ amt: CGFloat) -> CGRect {
        var f = self
        f.origin.y = amt
        return f
    }

    func withWidth(_ amt: CGFloat) -> CGRect {
        var f = self
        f.size.width = amt
        return f
    }

    func withHeight(_ amt: CGFloat) -> CGRect {
        var f = self
        f.size.height = amt
        return f
    }

// MARK: inset(xxx:)
    func inset(all: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: all, left: all, bottom: all, right: all))
    }

    func inset(topBottom: CGFloat, sides: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: topBottom, left: sides, bottom: topBottom, right: sides))
    }

    func inset(topBottom: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: topBottom, left: 0, bottom: topBottom, right: 0))
    }

    func inset(sides: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: sides, bottom: 0, right: sides))
    }

    func inset(top: CGFloat, sides: CGFloat, bottom: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: top, left: sides, bottom: bottom, right: sides))
    }

    func inset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

    func inset(insets: UIEdgeInsets) -> CGRect {
        return UIEdgeInsetsInsetRect(self, insets)
    }

// MARK: shrinkXxx
    func shrinkLeft(_ amt: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: amt))
    }

    func shrinkRight(_ amt: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: amt, bottom: 0, right: 0))
    }

    func shrinkDown(_ amt: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: amt, left: 0, bottom: 0, right: 0))
    }

    func shrinkUp(_ amt: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: 0, bottom: amt, right: 0))
    }

// MARK: growXxx
    func grow(all: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -all, left: -all, bottom: -all, right: -all))
    }

    func grow(topBottom: CGFloat, sides: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -topBottom, left: -sides, bottom: -topBottom, right: -sides))
    }

    func grow(top: CGFloat, sides: CGFloat, bottom: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -top, left: -sides, bottom: -bottom, right: -sides))
    }

    func grow(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right))
    }

    func growLeft(_ amt: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: -amt, bottom: 0, right: 0))
    }

    func growRight(_ amt: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -amt))
    }

    func growUp(_ amt: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -amt, left: 0, bottom: 0, right: 0))
    }

    func growDown(_ amt: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: 0, bottom: -amt, right: 0))
    }

// MARK: fromXxx
    func fromTop() -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: 0)
    }

    func fromBottom() -> CGRect {
        return CGRect(x: minX, y: maxY, width: width, height: 0)
    }

    func fromLeft() -> CGRect {
        return CGRect(x: minX, y: minY, width: 0, height: height)
    }

    func fromRight() -> CGRect {
        return CGRect(x: maxX, y: minY, width: 0, height: height)
    }

// MARK: shiftXxx
    func shiftUp(_ amt: CGFloat) -> CGRect {
        return self.atY(self.y - amt)
    }

    func shiftDown(_ amt: CGFloat) -> CGRect {
        return self.atY(self.y + amt)
    }

    func shiftLeft(_ amt: CGFloat) -> CGRect {
        return self.atX(self.x - amt)
    }

    func shiftRight(_ amt: CGFloat) -> CGRect {
        return self.atX(self.x + amt)
    }

}
