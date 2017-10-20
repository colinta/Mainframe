////
/// ButtonArtist.swift
//

class ButtonArtist: Artist {
    var style: ButtonStyle = .None
    var borderColor: UIColor?

    override func draw(context: CGContext) {
        guard let borderColor = borderColor else { return }

        context.setLineWidth(1)
        context.setStrokeColor(borderColor.cgColor)

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
