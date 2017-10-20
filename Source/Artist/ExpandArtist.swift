////
/// ExpandArtist.swift
//

class ExpandArtist: Artist {
    var color: UIColor = .white

    required init() {
        super.init()
        size = CGSize(40)
    }

    override func draw(context: CGContext) {
        context.setLineWidth(3)
        context.setStrokeColor(color.cgColor)
        context.move(to: CGPoint(5, 34))
        context.addLine(to: CGPoint(15, 25))
        context.addEllipse(in: CGRect(
            x: 11, y: 9,
            width: 20, height: 20
            ))
        context.drawPath(using: .stroke)
    }

}
