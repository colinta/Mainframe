//
//  Nodeable.swift
//  Mainframe
//
//  Created by Colin Gray on 4/24/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

protocol Nodeable {
    func asNode() -> Node
}
protocol Buttonable {
    func asButton() -> Button
}

extension String: Nodeable, Buttonable {
    func asNode() -> Node {
        let n = TextNode()
        n.text = self
        return n
    }
    func asButton() -> Button {
        let n = Button()
        n.text = self
        return n
    }
}

extension Node: Nodeable {
    func asNode() -> Node {
        return self
    }
}

extension Button: Buttonable {
    func asButton() -> Button {
        return self
    }
}
