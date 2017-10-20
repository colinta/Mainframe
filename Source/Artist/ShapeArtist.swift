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
    var drawingMode: CGPathDrawingMode = .fill

    override func draw(context: CGContext) {
        if let fillColor = fillColor {
            context.setFillColor(fillColor.cgColor)
        }
        if let lineWidth = lineWidth {
            context.setLineWidth(lineWidth)
        }
        if let strokeColor = strokeColor {
            context.setStrokeColor(strokeColor.cgColor)
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
        self.init(.zero, .white)
    }

    override func draw(context: CGContext) {
        super.draw(context: context)

        context.addRect(CGRect(origin: .zero, size: size))
        context.drawPath(using: drawingMode)
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
        self.init(.zero, .white)
    }

    override func draw(context: CGContext) {
        super.draw(context: context)

        context.addEllipse(in: CGRect(origin: .zero, size: size))
        context.drawPath(using: drawingMode)
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
        drawingMode = .stroke
        strokeColor = color
        lineWidth = 1.pixels
    }

    required init() {
        fatalError("init() has not been implemented")
    }

    override func draw(context: CGContext) {
        super.draw(context: context)

        context.translateBy(x: 0, y: middle.y)
        let p1 = CGPoint(x: 0)
        let p2 = CGPoint(x: size.width)
        context.move(to: CGPoint(p1.x, 0))
        context.addLine(to: CGPoint(p2.x, 0))
        context.drawPath(using: drawingMode)
    }

}

class PathArtist: ShapeArtist {
    let path: UIBezierPath

    required init(_ path: UIBezierPath, _ color: UIColor) {
        self.path = path.copy() as! UIBezierPath
        self.path.apply(CGAffineTransform(scaleX: 1, y: -1))
        super.init()
        self.drawingMode = .stroke
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
        super.draw(context: context)

        let bounds = path.bounds
        context.translateBy(x: -bounds.minX, y: -bounds.minY)
        let cgpath = path.cgPath
        context.addPath(cgpath)
        context.drawPath(using: drawingMode)
    }

}
