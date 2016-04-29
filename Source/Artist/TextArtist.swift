//
//  TextArtist.swift
//  FlatoutWar
//
//  Created by Colin Gray on 8/2/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
//

class TextArtist: Artist {
    var text = "" { didSet { calculateSize() }}
    private var textSize: CGSize = .zero

    var color = UIColor(hex: 0xFFFFFF)
    var font: Font = SmallFont {
        didSet {
            calculateSize()
        }
    }
    private var textStroke: CGFloat { return font.stroke }
    private var textScale: CGFloat { return font.scale }
    private var letterSpace: CGFloat { return font.space }

    func calculateSize() {
        var size = CGSize(width: 0, height: 0)
        var isFirst = true
        for char in (text.characters.map { String($0) }) {
            let letter = font.art[char] ?? Letter(style: .Line, size: CGSize.zero, points: [])
            if !isFirst {
                size.width += letterSpace
            }
            isFirst = false
            size.width += letter.size.width
            size.height = max(letter.size.height, size.height)
        }
        size *= textScale
        self.size = size
        self.textSize = size
    }

    override func draw(context: CGContext) {
        CGContextSetLineWidth(context, 0.5)
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextSetFillColorWithColor(context, color.CGColor)

        CGContextSaveGState(context)
        CGContextScaleCTM(context, textScale, textScale)
        CGContextTranslateCTM(context, (size.width - textSize.width) / 2, (size.height - textSize.height) / 2)
        for char in (text.characters.map { String($0) }) {
            let letter = font.art[char] ?? Letter(style: .Line, size: CGSize.zero, points: [])
            for path in letter.points {
                var firstPoint = true
                for pt in path {
                    if firstPoint {
                        CGContextMoveToPoint(context, pt.x, pt.y)
                        firstPoint = false
                    }
                    else {
                        CGContextAddLineToPoint(context, pt.x, pt.y)
                    }
                }

                if letter.style == .Loop || letter.style == .Fill {
                    CGContextClosePath(context)
                }
            }

            if letter.style == .Fill {
                CGContextDrawPath(context, .Fill)
            }
            else {
                CGContextDrawPath(context, .Stroke)
            }
            CGContextTranslateCTM(context, letter.size.width + letterSpace, 0)
        }
        CGContextRestoreGState(context)
    }

}
