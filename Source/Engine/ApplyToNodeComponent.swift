//
//  ApplyToNodeComponent.swift
//  FlatoutWar
//
//  Created by Colin Gray on 12/31/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
//

class ApplyToNodeComponent: Component {
    private var didSetApplyTo = false
    weak var applyTo: SKNode? {
        didSet {
            didSetApplyTo = true
        }
    }
    override weak var node: Node! {
        didSet {
            if !didSetApplyTo {
                defaultApplyTo()
            }
        }
    }

    func defaultApplyTo() {
        applyTo = node
    }

    func apply(block: (SKNode) -> Void) {
        if let node = applyTo {
            block(node)
        }
    }

    override func reset() {
        super.reset()
        applyTo = nil
    }

}
