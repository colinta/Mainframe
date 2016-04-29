//
//  Line.swift
//  FlatoutWar
//
//  Created by Colin Gray on 4/18/2016.
//  Copyright (c) 2016 FlatoutWar. All rights reserved.
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

    override func encodeWithCoder(encoder: NSCoder) {
        super.encodeWithCoder(encoder)
    }

}
