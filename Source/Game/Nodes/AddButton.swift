//
//  AddButton.swift
//  Mainframe
//
//  Created by Colin Gray on 4/28/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

class AddButton: Button {
    var dragBeginPoint: CGPoint?
    var addToPoint: CGPoint?
    var newNode = MathNode()

    required init() {
        super.init()
        style = .CircleSized(20)
        text = "+"
        newNode.alpha = 0
        newNode.op = .NoOpSelected
        self << newNode

        let defaultOffset = CGPoint(x: 60, y: -10)

        touchableComponent?.off(.Enter, .Exit)

        touchableComponent?.on(.Down) { pt in
            self.dragBeginPoint = pt + defaultOffset
            let newPoint = pt + defaultOffset
            self.addToPoint = newPoint
            self.newNode.position = newPoint
            self.newNode.fadeTo(0.5, rate: 3.333)
        }
        touchableComponent?.on(.DragMoved) { pt in
            let newPoint = pt + defaultOffset
            self.newNode.position = newPoint
            self.addToPoint = newPoint
        }
        touchableComponent?.on(.Up) { pt in
            if let addToPoint = self.addToPoint {
                self.addNode(at: addToPoint)
            }
            self.addToPoint = nil
            self.dragBeginPoint = nil
            self.newNode.fadeTo(0, start: 0, rate: 3.333) // to cancel previous fade-in
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addNode(at delta: CGPoint? = nil) {
        addNode(MathNode(), at: delta)
    }

    func addNode(node: MathNode, at delta: CGPoint? = nil) {
        guard let mainframe = world as? Mainframe else { return }

        let position: CGPoint
        if let delta = delta {
            position = mainframe.convertPoint(self.position, toNode: mainframe.tree) + delta
        }
        else {
            position = mainframe.topNode.position + CGPoint(x: 75)
        }

        node.position = position
        mainframe.tree << node
        mainframe.currentOp = node
    }

}
