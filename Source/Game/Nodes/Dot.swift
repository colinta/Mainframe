//
//  Dot.swift
//  FlatoutWar
//
//  Created by Colin Gray on 1/14/2016.
//  Copyright (c) 2016 FlatoutWar. All rights reserved.
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
