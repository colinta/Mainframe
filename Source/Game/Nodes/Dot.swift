////
/// Dot.swift
//

class Dot: Node {
    let sprite = SKSpriteNode(id: .Dot(color: 0x808080))

    required init() {
        super.init()
        self << sprite
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
