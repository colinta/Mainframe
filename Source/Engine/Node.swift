//
//  Node.swift
//  Mainframe
//
//  Created by Colin Gray on 12/21/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
//

class Node: SKNode {
    var size: CGSize = .zero
    var radius: CGFloat {
        if size.width == size.height {
            return size.width / 2
        }
        return (size.width + size.height) / 4
    }
    var fixedPosition: Position? {
        didSet {
            world?.updateFixedNode(self)
        }
    }

    var components: [Component] = []
    var world: World? { return (scene as? WorldScene)?.world }

    weak var fadeToComponent: FadeToComponent?
    weak var jiggleComponent: JiggleComponent?
    weak var moveToComponent: MoveToComponent?
    weak var phaseComponent: PhaseComponent?
    weak var scaleToComponent: ScaleToComponent?
    weak var selectableComponent: SelectableComponent?
    weak var touchableComponent: TouchableComponent?

    convenience init(at point: CGPoint) {
        self.init()
        position = point
    }

    convenience init(fixed position: Position) {
        self.init()
        fixedPosition = position
    }

    override required init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func encodeWithCoder(encoder: NSCoder) {
        super.encodeWithCoder(encoder)
    }

    func reset() {
        for component in components {
            component.reset()
        }
        for node in allChildNodes(recursive: false) {
            node.reset()
        }
    }

    func update(dt: CGFloat) {
    }

    var dontReset = false
    override func moveToParent(node: SKNode) {
        dontReset = true
        super.moveToParent(node)
        dontReset = false
    }

    override func insertChild(node: SKNode, atIndex index: Int) {
        super.insertChild(node, atIndex: index)
        if let world = world, node = node as? Node where world != self {
            world.processNewNode(node)
        }
    }

    override func removeFromParent() {
        if let world = world where !dontReset {
            world.willRemove([self] + allChildNodes())
            reset()
        }
        super.removeFromParent()
    }

    func allChildNodes(recursive recursive: Bool = true) -> [Node] {
        let nodes = children.filter { sknode in
            return sknode is Node
        } as! [Node]
        return nodes + (recursive ? nodes.flatMap { childNode in
            childNode.allChildNodes()
        } : [])
    }

}

// MARK: Update Cycle

extension Node {

    func updateNodes(dt: CGFloat) {
        guard world != nil else { return }

        for component in components {
            if component.enabled {
                component.update(dt)
            }
        }
        update(dt)
        for sknode in children {
            if let node = sknode as? Node {
                node.updateNodes(dt)
            }
        }
    }

}

// MARK: Add/Remove Components

extension Node {

    func addComponent(component: Component) {
        component.node = self
        components << component

        if let component = component as? FadeToComponent { fadeToComponent = component }
        if let component = component as? JiggleComponent { jiggleComponent = component }
        if let component = component as? MoveToComponent { moveToComponent = component }
        if let component = component as? PhaseComponent { phaseComponent = component }
        if let component = component as? ScaleToComponent { scaleToComponent = component }
        if let component = component as? SelectableComponent { selectableComponent = component }
        if let component = component as? TouchableComponent { touchableComponent = component }

        component.didAddToNode()
    }

    func removeComponent(component: Component) {
        if let index = components.indexOf(component) {
            if component == fadeToComponent { fadeToComponent = nil }
            if component == jiggleComponent { jiggleComponent = nil }
            if component == moveToComponent { moveToComponent = nil }
            if component == phaseComponent { phaseComponent = nil }
            if component == scaleToComponent { scaleToComponent = nil }
            if component == selectableComponent { selectableComponent = nil }
            if component == touchableComponent { touchableComponent = nil }

            components.removeAtIndex(index)
        }
    }

}
