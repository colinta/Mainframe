////
/// ButtonArtist.swift
//

class ButtonArtist: Artist {
    var style: ButtonStyle = .none
    var borderColor: UIColor?

    override func draw(context: CGContext) {
        guard let borderColor = borderColor else { return }

        context.setLineWidth(1)
        context.setStrokeColor(borderColor.cgColor)

        switch style {
        case .squareSized, .rectSized:
            context.addRect(CGRect(origin: .zero, size: size))
            context.drawPath(using: .stroke)
        case .circleSized:
            context.addEllipse(in: CGRect(origin: .zero, size: size))
            context.drawPath(using: .stroke)
        case .none, .rectToFit:
            break
        }
    }

}
