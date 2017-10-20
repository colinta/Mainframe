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
        super.draw(context: context)

        context.setLineWidth(1)
        context.setStrokeColor(color.cgColor)

        switch style {
        case .Square, .SquareSized, .RectSized:
            context.addRect(CGRect(origin: .zero, size: size))
            context.drawPath(using: .stroke)
        case .Circle, .CircleSized:
            context.addEllipse(in: CGRect(origin: .zero, size: size))
            context.drawPath(using: .stroke)
        case .None, .RectToFit:
            break
        }
    }

}
