//
//  ShapeArtists.swift
//  Mainframe
//
//  Created by Colin Gray on 8/25/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
//

class ShapeArtist: Artist {
    var strokeColor: UIColor?
    var fillColor: UIColor?
    var lineWidth: CGFloat?
    var drawingMode: CGPathDrawingMode = .Fill

    override func draw(context: CGContext) {
        if let fillColor = fillColor {
            CGContextSetFillColorWithColor(context, fillColor.CGColor)
        }
        if let lineWidth = lineWidth {
            CGContextSetLineWidth(context, lineWidth)
        }
        if let strokeColor = strokeColor {
            CGContextSetStrokeColorWithColor(context, strokeColor.CGColor)
        }
    }
}

class RectArtist: ShapeArtist {
    required init(_ size: CGSize, _ color: UIColor) {
        super.init()
        self.fillColor = color
        self.strokeColor = color
        self.size = size
    }

    convenience required init() {
        self.init(.zero, .whiteColor())
    }

    override func draw(context: CGContext) {
        super.draw(context)

        CGContextAddRect(context, CGRect(origin: .zero, size: size))
        CGContextDrawPath(context, drawingMode)
    }
}

class CircleArtist: ShapeArtist {
    required init(_ size: CGSize, _ color: UIColor) {
        super.init()
        self.fillColor = color
        self.strokeColor = color
        self.size = size
    }

    convenience required init() {
        self.init(.zero, .whiteColor())
    }

    override func draw(context: CGContext) {
        super.draw(context)

        CGContextAddEllipseInRect(context, CGRect(origin: .zero, size: size))
        CGContextDrawPath(context, drawingMode)
    }
}

class LineArtist: ShapeArtist {
    override var lineWidth: CGFloat? {
        didSet {
            if let lineWidth = lineWidth {
                size = CGSize(width: size.width, height: max(lineWidth, 1))
            }
        }
    }

    required init(_ length: CGFloat, _ color: UIColor) {
        super.init()
        size = CGSize(width: length, height: 1)
        drawingMode = .Stroke
        strokeColor = color
        lineWidth = 1.pixels
    }

    required init() {
        fatalError("init() has not been implemented")
    }

    override func draw(context: CGContext) {
        super.draw(context)

        CGContextTranslateCTM(context, 0, middle.y)
        let p1 = CGPoint(x: 0)
        let p2 = CGPoint(x: size.width)
        CGContextMoveToPoint(context, p1.x, 0)
        CGContextAddLineToPoint(context, p2.x, 0)
        CGContextDrawPath(context, drawingMode)
    }

}

class PathArtist: ShapeArtist {
    let path: UIBezierPath

    required init(_ path: UIBezierPath, _ color: UIColor) {
        self.path = path.copy() as! UIBezierPath
        self.path.applyTransform(CGAffineTransformMakeScale(1, -1))
        super.init()
        self.drawingMode = .Stroke
        self.strokeColor = color
        self.lineWidth = 1.pixels

        let bounds = path.bounds
        let width = bounds.width
        let height = bounds.height
        size = CGSize(width: width, height: height)
    }

    required init() {
        fatalError("init() has not been implemented")
    }

    override func draw(context: CGContext) {
        super.draw(context)

        let bounds = path.bounds
        CGContextTranslateCTM(context, -bounds.minX, -bounds.minY)
        let cgpath = path.CGPath
        CGContextAddPath(context, cgpath)
        CGContextDrawPath(context, drawingMode)
    }

}
