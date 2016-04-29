//
//  ButtonArtist.swift
//  FlatoutWar
//
//  Created by Colin Gray on 8/2/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
//

class ButtonArtist: Artist {
    var style: ButtonStyle = .None
    var color = UIColor(hex: 0xFFFFFF)

    override func draw(context: CGContext) {
        super.draw(context)

        CGContextSetLineWidth(context, 1)
        CGContextSetStrokeColorWithColor(context, color.CGColor)

        switch style {
        case .Square, .SquareSized, .RectSized:
            CGContextAddRect(context, CGRect(origin: .zero, size: size))
            CGContextDrawPath(context, .Stroke)
        case .Circle, .CircleSized:
            CGContextAddEllipseInRect(context, CGRect(origin: .zero, size: size))
            CGContextDrawPath(context, .Stroke)
        case .None, .RectToFit:
            break
        }
    }

}
