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
        self << newNode

        touchableComponent?.off(.Enter, .Exit)

        touchableComponent?.on(.Tapped) { _ in
            self.addNode()
        }
        touchableComponent?.on(.DragMoved) { pt in
            guard let beginPt = self.dragBeginPoint else { return }

            let minDist: CGFloat = 15
            let offset: CGFloat = 30
            let dist = pt.distanceTo(beginPt)

            let newPoint = pt + CGPoint(x: offset)
            self.newNode.position = newPoint

            if dist >= minDist {
                self.newNode.fadeTo(0.5, rate: 3.333)
                self.addToPoint = newPoint
            }
            else {
                self.newNode.fadeTo(0, rate: 3.333)
                self.addToPoint = nil
            }
        }
        touchableComponent?.on(.DragEnded) { pt in
            if let addToPoint = self.addToPoint {
                self.addNode(at: addToPoint)
            }
            self.dragBeginPoint = nil
            self.newNode.alpha = 0
        }

        touchableComponent?.on(.DragBegan) { pt in
            self.dragBeginPoint = pt
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addNode(at delta: CGPoint? = nil) {
        guard let mainframe = world as? Mainframe else { return }

        let position: CGPoint
        if let delta = delta {
            position = mainframe.convertPoint(self.position, toNode: mainframe.tree) + delta
        }
        else {
            position = mainframe.topNode.position + CGPoint(x: 75)
        }
        let node = MathNode()
        node.position = position
        mainframe.tree << node
    }

}
