//
//  World.swift
//  Mainframe
//
//  Created by Colin Gray on 12/21/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
//

class World: Node {
    var screenSize: CGSize! {
        didSet {
            updateFixedNodes()
        }
    }
    var isUpdating = false
    private var didPopulateWorld = false

    var director: WorldView? {
        return (scene as? WorldScene)?.view as? WorldView
    }

    var touchedNode: Node?
    var currentNode: Node? { return selectedNode ?? defaultNode }
    var defaultNode: Node?
    var selectedNode: Node? {
        willSet {
            if let selectedNode = selectedNode
            where selectedNode != newValue {
                selectedNode.selectableComponent?.changeSelected(false)
            }
        }
        didSet {
            if let selectedNode = selectedNode {
                selectedNode.selectableComponent?.changeSelected(true)
            }
        }
    }

    override func encodeWithCoder(encoder: NSCoder) {
        super.encodeWithCoder(encoder)
    }

    private func _populateWorld() {
    }

    func populateWorld() {
    }

    func restartWorld() {
        director?.presentWorld(self.dynamicType.init())
    }

}

extension World {

    // also called by addChild
    override func insertChild(node: SKNode, atIndex index: Int) {
        super.insertChild(node, atIndex: index)
        if let node = node as? Node {
            processNewNode(node)
        }
    }

    func processNewNode(node: Node) {
        let newNodes = [node] + node.allChildNodes()
        for node in newNodes {
            didAdd(node)
        }

        let fixedPositions = newNodes.any { $0.fixedPosition != nil }
        if fixedPositions {
            updateFixedNodes()
        }
    }

    func didAdd(node: Node) {
    }

    func willRemove(nodes: [Node]) {
        for node in nodes {
            if node === defaultNode {
                defaultNode = nil
            }
            if node === selectedNode {
                selectedNode = nil
            }
            if node === touchedNode {
                touchedNode = nil
            }
        }
    }

}

extension World {

    func updateWorld(dt: CGFloat) {
        if !didPopulateWorld {
            _populateWorld()
            populateWorld()
            didPopulateWorld = true
        }

        updateNodes(dt)
    }

}

extension World {

    func selectNode(node: Node) {
        selectedNode = node
    }

    func unselectNode(node: Node) {
        if selectedNode == node {
            selectedNode = nil
        }
    }

}

extension World {

    func worldShook() {
    }

    func worldTapped(worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convertPoint(worldLocation, toNode: touchedNode)
        touchedNode.touchableComponent?.tapped(location)
    }

    func worldPressed(worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convertPoint(worldLocation, toNode: touchedNode)
        touchedNode.touchableComponent?.pressed(location)
    }

    func worldTouchBegan(worldLocation: CGPoint) {
        if let touchedNode = touchableNodeAtLocation(worldLocation) {
            self.touchedNode = touchedNode
        }
        else {
            self.touchedNode = defaultNode
        }

        if let touchedNode = self.touchedNode {
            let location = convertPoint(worldLocation, toNode: touchedNode)

            if let shouldAcceptTest = touchedNode.touchableComponent?.shouldAcceptTouch(location)
            where !shouldAcceptTest {
                self.touchedNode = nil
            }
            else {
                touchedNode.touchableComponent?.touchBegan(location)
            }
        }
    }

    func worldTouchEnded(worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convertPoint(worldLocation, toNode: touchedNode)
        touchedNode.touchableComponent?.touchEnded(location)

        self.touchedNode = nil
    }

    func worldDraggingBegan(worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convertPoint(worldLocation, toNode: touchedNode)
        touchedNode.touchableComponent?.draggingBegan(location)
    }

    func worldDraggingMoved(worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convertPoint(worldLocation, toNode: touchedNode)
        touchedNode.touchableComponent?.draggingMoved(location)
    }

    func worldDraggingEnded(worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convertPoint(worldLocation, toNode: touchedNode)
        touchedNode.touchableComponent?.draggingEnded(location)
    }

}

extension World {
    func touchableNodeAtLocation(worldLocation: CGPoint) -> Node? {
        return touchableNodeAtLocation(worldLocation, inChildren: allChildNodes())
    }

    private func touchableNodeAtLocation(worldLocation: CGPoint, inChildren children: [Node]) -> Node? {
        for node in children.reverse() {
            if let touchableComponent = node.touchableComponent
            where touchableComponent.enabled && node.visible {
                let nodeLocation = convertPoint(worldLocation, toNode: node)
                if touchableComponent.containsTouch(nodeLocation) {
                    return node
                }
            }
        }
        return nil
    }

}

extension World {

    func updateFixedNodes() {
        if screenSize != nil {
            for node in allChildNodes() {
                if let fixedPosition = node.fixedPosition {
                    node.position = calculateFixedPosition(fixedPosition)
                }
            }
        }
    }

    func updateFixedNode(node: Node) {
        if let fixedPosition = node.fixedPosition where screenSize != nil {
            node.position = calculateFixedPosition(fixedPosition)
        }
    }

    func calculateFixedPosition(position: Position) -> CGPoint {
        return position.positionIn(screenSize: screenSize ?? CGSize.zero)
    }

}
