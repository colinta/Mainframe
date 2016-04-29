//
//  CGRectExt.swift
//  Mainframe
//
//  Created by Colin Gray on 7/18/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
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

    static func at(x x: CGFloat, y: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: 0, height: 0)
    }

// MARK: helpers
    var x:CGFloat { return self.origin.x }
    var y:CGFloat { return self.origin.y }
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }

// MARK: dimension setters
    func atOrigin(amt:CGPoint) -> CGRect {
        var f = self
        f.origin = amt
        return f
    }

    func withSize(amt:CGSize) -> CGRect {
        var f = self
        f.size = amt
        return f
    }

    func atX(amt:CGFloat) -> CGRect {
        var f = self
        f.origin.x = amt
        return f
    }

    func atY(amt:CGFloat) -> CGRect {
        var f = self
        f.origin.y = amt
        return f
    }

    func withWidth(amt:CGFloat) -> CGRect {
        var f = self
        f.size.width = amt
        return f
    }

    func withHeight(amt:CGFloat) -> CGRect {
        var f = self
        f.size.height = amt
        return f
    }

// MARK: inset(xxx:)
    func inset(all all:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: all, left: all, bottom: all, right: all))
    }

    func inset(topBottom topBottom:CGFloat, sides: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: topBottom, left: sides, bottom: topBottom, right: sides))
    }

    func inset(topBottom topBottom:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: topBottom, left: 0, bottom: topBottom, right: 0))
    }

    func inset(sides sides: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: sides, bottom: 0, right: sides))
    }

    func inset(top top:CGFloat, sides: CGFloat, bottom: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: top, left: sides, bottom: bottom, right: sides))
    }

    func inset(top top:CGFloat, left:CGFloat, bottom:CGFloat, right:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

    func inset(insets: UIEdgeInsets) -> CGRect {
        return UIEdgeInsetsInsetRect(self, insets)
    }

// MARK: shrinkXxx
    func shrinkLeft(amt:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: amt))
    }

    func shrinkRight(amt:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: amt, bottom: 0, right: 0))
    }

    func shrinkDown(amt:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: amt, left: 0, bottom: 0, right: 0))
    }

    func shrinkUp(amt:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: 0, bottom: amt, right: 0))
    }

// MARK: growXxx
    func grow(all all:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -all, left: -all, bottom: -all, right: -all))
    }

    func grow(topBottom topBottom:CGFloat, sides: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -topBottom, left: -sides, bottom: -topBottom, right: -sides))
    }

    func grow(top top:CGFloat, sides: CGFloat, bottom: CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -top, left: -sides, bottom: -bottom, right: -sides))
    }

    func grow(top top:CGFloat, left:CGFloat, bottom:CGFloat, right:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right))
    }

    func growLeft(amt:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: -amt, bottom: 0, right: 0))
    }

    func growRight(amt:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -amt))
    }

    func growUp(amt:CGFloat) -> CGRect {
        return UIEdgeInsetsInsetRect(self, UIEdgeInsets(top: -amt, left: 0, bottom: 0, right: 0))
    }

    func growDown(amt:CGFloat) -> CGRect {
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
    func shiftUp(amt:CGFloat) -> CGRect {
        return self.atY(self.y - amt)
    }

    func shiftDown(amt:CGFloat) -> CGRect {
        return self.atY(self.y + amt)
    }

    func shiftLeft(amt:CGFloat) -> CGRect {
        return self.atX(self.x - amt)
    }

    func shiftRight(amt:CGFloat) -> CGRect {
        return self.atX(self.x + amt)
    }

}
