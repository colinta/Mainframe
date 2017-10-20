////
/// World.swift
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
            if let selectedNode = selectedNode,
                selectedNode != newValue
            {
                selectedNode.selectableComponent?.changeSelected(false)
            }
        }
        didSet {
            if let selectedNode = selectedNode {
                selectedNode.selectableComponent?.changeSelected(true)
            }
        }
    }

    override func encode(with encoder: NSCoder) {
        super.encode(with: encoder)
    }

    private func _populateWorld() {
    }

    func populateWorld() {
    }

    func restartWorld() {
        director?.presentWorld(type(of: self).init())
    }

    func worldShook() {
    }

}

extension World {

    // also called by addChild
    override func insertChild(_ node: SKNode, at index: Int) {
        super.insertChild(node, at: index)
        if let node = node as? Node {
            processNewNode(node)
        }
    }

    func processNewNode(_ node: Node) {
        let newNodes = [node] + node.allChildNodes()
        for node in newNodes {
            didAdd(node)
        }

        let fixedPositions = newNodes.any { $0.fixedPosition != nil }
        if fixedPositions {
            updateFixedNodes()
        }
    }

    func didAdd(_ node: Node) {
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

    func updateWorld(_ dt: CGFloat) {
        if !didPopulateWorld {
            _populateWorld()
            populateWorld()
            didPopulateWorld = true
        }

        updateNodes(dt)
    }

}

extension World {

    func selectNode(_ node: Node) {
        selectedNode = node
    }

    func unselectNode(_ node: Node) {
        if selectedNode == node {
            selectedNode = nil
        }
    }

}

extension World {

    func worldTapped(_ worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convert(worldLocation, to: touchedNode)
        touchedNode.touchableComponent?.tapped(location)
    }

    func worldPressed(_ worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convert(worldLocation, to: touchedNode)
        touchedNode.touchableComponent?.pressed(location)
    }

    func worldTouchBegan(_ worldLocation: CGPoint) {
        if let touchedNode = touchableNodeAtLocation(worldLocation) {
            self.touchedNode = touchedNode
        }
        else {
            self.touchedNode = defaultNode
        }

        if let touchedNode = self.touchedNode {
            let location = convert(worldLocation, to: touchedNode)

            if let shouldAcceptTest = touchedNode.touchableComponent?.shouldAcceptTouch(at: location), !shouldAcceptTest {
                self.touchedNode = nil
            }
            else {
                touchedNode.touchableComponent?.touchBegan(location)
            }
        }

        touchedNode.map { touchedNode in print("touched node is \(touchedNode)") }
    }

    func worldTouchEnded(_ worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convert(worldLocation, to: touchedNode)
        touchedNode.touchableComponent?.touchEnded(location)

        self.touchedNode = nil
    }

    func worldDraggingBegan(_ worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convert(worldLocation, to: touchedNode)
        touchedNode.touchableComponent?.draggingBegan(location)
    }

    func worldDraggingMoved(_ worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convert(worldLocation, to: touchedNode)
        touchedNode.touchableComponent?.draggingMoved(location)
    }

    func worldDraggingEnded(_ worldLocation: CGPoint) {
        guard let touchedNode = touchedNode else { return }

        let location = convert(worldLocation, to: touchedNode)
        touchedNode.touchableComponent?.draggingEnded(location)
    }

}

extension World {
    func touchableNodeAtLocation(_ worldLocation: CGPoint) -> Node? {
        let sortedChildren = allChildNodes().sorted { a, b in
            return a.zPosition < b.zPosition
        }
        return touchableNodeAtLocation(worldLocation, inChildren: sortedChildren)
    }

    private func touchableNodeAtLocation(_ worldLocation: CGPoint, inChildren children: [Node]) -> Node? {
        for node in children.reversed() {
            if let touchableComponent = node.touchableComponent, touchableComponent.isEnabled, node.isVisible {
                let nodeLocation = convert(worldLocation, to: node)
                if touchableComponent.containsTouch(at: nodeLocation) {
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

    func updateFixedNode(_ node: Node) {
        if let fixedPosition = node.fixedPosition, screenSize != nil {
            node.position = calculateFixedPosition(fixedPosition)
        }
    }

    func calculateFixedPosition(_ position: Position) -> CGPoint {
        return position.positionIn(screenSize: screenSize ?? CGSize.zero)
    }

}
