//
//  Component.swift
//  Mainframe
//
//  Created by Colin Gray on 12/21/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
//

@objc
class Component: NSObject, NSCoding {
    var isEnabled = true
    weak var node: Node!

    func update(_ dt: CGFloat) {
    }

    func reset() {
    }

    override init() {
    }

    func didAddToNode() {
    }

    func removeFromNode() {
        if let node = node {
            node.removeComponent(self)
        }
        reset()
    }

    required init?(coder: NSCoder) {
        super.init()
    }

    func encode(with encoder: NSCoder) {
    }

}

class GrowToComponent: Component {}
