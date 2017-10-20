////
/// Line.swift
//

class Line: Node {
    let sprite = SKSpriteNode()

    required init(from p1: CGPoint, to p2: CGPoint, color: Int = 0xFFFFFF) {
        super.init()
        position = p1
        zRotation = p1.angleTo(p2)
        let length = p1.distanceTo(p2)
        sprite.textureId(.ColorLine(length: length, color: color))
        sprite.anchorPoint = CGPoint(0, 0.5)
        self << sprite
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    required init() {
        fatalError("init() has not been implemented")
    }

    override func encode(with encoder: NSCoder) {
        super.encode(with: encoder)
    }

}
