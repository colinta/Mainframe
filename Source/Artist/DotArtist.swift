////
/// DotArtist.swift
//

class DotArtist: Artist {
    var color: UIColor = .white

    required init() {
        super.init()
        size = CGSize(2)
    }

    override func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.addEllipse(in: CGRect(origin: .zero, size: size))
        context.drawPath(using: .fill)
    }

}
