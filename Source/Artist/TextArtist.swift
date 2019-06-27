////
/// TextArtist.swift
//

class TextArtist: Artist {
    var text = "" { didSet { calculateSize() }}
    private var textSize: CGSize = .zero

    var color = UIColor(hex: 0xFFFFFF)
    var font: Font = DefaultFont {
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
        for char in (text.map { String($0) }) {
            let letter = font.art[char] ?? Letter(style: .line, size: CGSize.zero, points: [])
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
        context.setLineWidth(0.5)
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.cgColor)

        context.saveGState()
        context.scaleBy(x: textScale, y: textScale)
        context.translateBy(x: (size.width - textSize.width) / 2, y: (size.height - textSize.height) / 2)
        for char in (text.map { String($0) }) {
            let letter = font.art[char] ?? Letter(style: .line, size: CGSize.zero, points: [])
            for path in letter.points {
                var firstPoint = true
                for pt in path {
                    if firstPoint {
                        context.move(to: CGPoint(pt.x, pt.y))
                        firstPoint = false
                    }
                    else {
                        context.addLine(to: CGPoint(pt.x, pt.y))
                    }
                }

                if letter.style == .loop || letter.style == .fill {
                    context.closePath()
                }
            }

            if letter.style == .fill {
                context.drawPath(using: .fill)
            }
            else {
                context.drawPath(using: .stroke)
            }
            context.translateBy(x: letter.size.width + letterSpace, y: 0)
        }
        context.restoreGState()
    }

}
