//
//  MathNode.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

class MathNode: Node {
    var numberString = ""
    var prevOp: Operation = .NoOp
    var op: Operation = .NoOp {
        willSet { prevOp = op }
        didSet { updateMathNodes() }
    }
    var topMostParent: MathNode {
        var retval = self
        while let parent = retval.parent as? MathNode {
            retval = parent
        }
        return retval
    }
    var mathChildren: [MathNode] { return allChildNodes(recursive: false).filter {
            $0 is MathNode
        } as! [MathNode]
    }
    var activeMathChildren: [MathNode] { return mathChildren.filter { $0.active && !$0.op.isNoOp } }
    var parentLine = SKSpriteNode()
    var dragLine = SKSpriteNode()
    var dragParent: MathNode? {
        willSet {
            guard newValue != dragParent else { return }
            dragParent?.button.unhighlight()
            newValue?.button.highlight()
        }
    }
    var canReceiveChildren: Bool {
        if let maxChildNodes = op.maxChildNodes {
            return activeMathChildren.count < maxChildNodes
        }
        return true
    }

    let jiggle = JiggleComponent()
    var moving = false
    var dragging: Bool { return dragDest != nil }
    var dragDest: CGPoint?
    let button = Button()
    var buttonTimer: CGFloat?
    private let clearButton = Button()
    private var _clearEnabled = false {
        didSet {
            clearButton.hidden = !_clearEnabled
        }
    }
    var clearEnabled: Bool {
        set {
            _clearEnabled = newValue
            updateMathNodes()
        }
        get { return _clearEnabled }
    }
    var active = true

    typealias OnUpdate = (OperationResult) -> Void
    var _onUpdate: [OnUpdate] = []
    func onUpdate(handler: OnUpdate) {
        _onUpdate << handler
        handler(calculate())
    }

    required init() {
        super.init()

        parentLine.anchorPoint = CGPoint(0, 0.5)
        parentLine.z = .Bottom
        dragLine.hidden = true
        dragLine.anchorPoint = CGPoint(0, 0.5)
        dragLine.z = .Bottom
        self << button
        self << parentLine
        self << dragLine
        self << clearButton

        jiggle.enabled = false
        button.addComponent(jiggle)
        button.style = .SquareSized(25)
        button.touchableComponent?.on(.Down) { _ in
            self.moving = false
            self.buttonTimer = 0.5
        }
        button.touchableComponent?.on(.Up) { _ in
            if let dragParent = self.dragParent where self.dragParent != self.parent {
                let oldParent = self.parent as? MathNode
                self.moveToParent(dragParent)
                (self.world as? Mainframe)?.topNode = self.topMostParent
                dragParent.updateMathNodes()
                oldParent?.updateMathNodes()
            }

            self.moving = false
            self.buttonTimer = nil
            self.jiggle.enabled = false
            self.button.zRotation = 0
            self.dragLine.hidden = true
            self.dragDest = nil
            self.dragParent = nil
        }

        button.touchableComponent?.on(.DragBegan) { pt in
            if !self.moving {
                self.buttonTimer = nil
                self.dragDest = pt
            }
        }
        button.touchableComponent?.on(.DragMoved) { pt in
            if self.moving {
                self.position += pt
            }
            else if self.dragging {
                self.dragDest = pt
            }
        }
        button.touchableComponent?.on(.DragEnded) { pt in
            if self.dragging {
            }
        }
        button.onTapped {
            (self.world as? Mainframe)?.currentOp = self
        }

        clearButton.hidden = true
        clearButton.style = .CircleSized(20)
        clearButton.color = 0x0
        clearButton.border = 0xFFFFFF
        clearButton.background = 0xFFFFFF
        clearButton.text = "×"
        clearButton.textScale = 0.75
        clearButton.position = CGPoint(x: 25)
        clearButton.onTapped {
            guard let world = (self.world as? Mainframe) else { return }

            if self.op.isNoOp && self.topMostParent == self && world.hasManyTopNodes {
                self.removeFromParent()
                world.updateTopNode()
                return
            }

            for node in self.mathChildren {
                if world.currentOp == node {
                    world.currentOp = self
                }
                node.removeFromParent()
            }

            self._clearEnabled = false
            self.op = world.currentOp == self ? .NoOpSelected : .NoOp
        }

        updateSize()
    }

    override func insertChild(node: SKNode, atIndex index: Int) {
        var newIndex = index
        if let node = node as? MathNode
        where index == children.count && !node.op.isNoOp
        {
            newIndex = 0
            for (childIndex, child) in children.enumerate() {
                if let child = child as? MathNode where !child.op.isNoOp {
                    newIndex = childIndex + 1
                }
            }
        }
        super.insertChild(node, atIndex: newIndex)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func reset() {
        super.reset()
        _onUpdate = []
    }

    func formula(isTop isTop: Bool = false) -> String {
        return op.formula(activeMathChildren, isTop: isTop)
    }

    func calculate() -> OperationResult {
        return op.calculate(activeMathChildren)
    }

    private func updateMathNodes() {
        switch op {
        case .NoOp:
            button.text = ""
            button.style = .SquareSized(25)
        case .NoOpSelected:
            button.text = ""
            button.style = .SquareSized(50)
        case .Number:
            button.text = op.description
            button.style = .RectToFit
        default:
            button.text = op.treeDescription
            button.style = .RectToFit
        }

        let mainframe = self.world as? Mainframe
        let isCurrentOp = mainframe?.currentOp == self ?? false
        let childIsCurrentOp = isCurrentOp || (mainframe?.currentOp?.parent == self ?? false)

        button.textScale = isCurrentOp ? 1.5 : 1
        clearButton.position = CGPoint(x: button.size.width / 2 + 5 + clearButton.size.width / 2)

        var visibleNodes: [MathNode] = mathChildren
        var selectNode: MathNode?

        if let minCount = op.minChildNodes {
            if mathChildren.count < minCount {
                (minCount - mathChildren.count).times { (i: Int) in
                    let node = generateNode()
                    self << node
                    visibleNodes << node
                    if node.op.isNoOp && selectNode == nil {
                        selectNode = node
                    }
                }
            }
        }

        if !op.isNoOp {
            if let maxCount = op.maxChildNodes {
                if mathChildren.count > maxCount {
                    for node in mathChildren[maxCount..<mathChildren.count] {
                        node.fadeTo(0, duration: 0.3, removeNode: node.op.isNoOp)
                        node.active = false
                    }
                }
                visibleNodes = Array(mathChildren[0..<maxCount])
            }
            else if childIsCurrentOp && mathChildren.all({ !$0.op.isNoOp }) {
                let node = generateNode()
                self << node
                visibleNodes << node
                if node.op.isNoOp && selectNode == nil {
                    selectNode = node
                }
            }
            else if !childIsCurrentOp {
                for node in visibleNodes where node.op.isNoOp {
                    node.fadeTo(0, duration: 0.3, removeNode: true)
                    node.active = false
                }
                visibleNodes = visibleNodes.filter { !$0.op.isNoOp }
            }
        }

        let totalWidth: CGFloat
        if visibleNodes.count > 0 {
            totalWidth = visibleNodes.reduce(CGFloat(0)) { $0 + $1.size.width + 15 } - 15
            var x = -totalWidth / 2
            let y: CGFloat = -75
            for node in visibleNodes {
                node.active = true
                if node.alpha < 1 {
                    node.fadeTo(1, rate: 3.3)
                }

                let position = CGPoint(x + node.size.width / 2, y)
                node.moveTo(position, duration: 0.3)
                x += node.size.width + 15
            }
        }
        else {
            totalWidth = 0
        }

        switch op {
        case .Number: break
        default: numberString = ""
        }

        updateSize()

        (parent as? MathNode)?.updateMathNodes()

        for handler in _onUpdate {
            handler(calculate())
        }

        if let selectNode = selectNode
        where isCurrentOp
        {
            mainframe?.currentOp = selectNode
        }
    }

    private func updateSize() {
        size = CGSize(width: button.size.width + (clearEnabled ? 5 + clearButton.size.width : 0), height: 50)
    }

    private func generateNode() -> MathNode {
        let node = MathNode()
        node.alpha = 0
        switch prevOp {
        case .Number, .Variable:
            node.numberString = numberString
            node.op = prevOp
        default: break
        }
        prevOp = .NoOp
        numberString = ""
        return node
    }

    override func update(dt: CGFloat) {
        if let buttonTimer = buttonTimer {
            self.buttonTimer = buttonTimer - dt
        }

        if parent is MathNode {
            parentLine.hidden = false
            parentLine.zRotation = TAU_2 + position.angle
            parentLine.textureId(.ColorLine(length: position.length, color: 0xFFFFFF))

            if let buttonTimer = buttonTimer where buttonTimer <= 0 {
                if let mainframe = world as? Mainframe {
                    let oldParent = self.parent as? MathNode
                    let treePosition = mainframe.tree.convertPoint(.zero, fromNode: self)
                    self.moveToParent(mainframe.tree)
                    self.position = treePosition
                    mainframe.topNode = self
                    self.updateMathNodes()
                    oldParent?.updateMathNodes()
                }
            }
        }
        else {
            parentLine.hidden = true

            if let buttonTimer = buttonTimer where buttonTimer <= 0 {
                self.buttonTimer = nil
                self.moving = true
                self.jiggle.enabled = true
            }

            if let dragDest = dragDest {
                dragLine.hidden = false
                dragLine.zRotation = dragDest.angle
                dragLine.textureId(.ColorLine(length: dragDest.length, color: 0xFFFFFF))

                if let world = world {
                    let worldPosition = world.convertPoint(dragDest, fromNode: self)
                    if let button = world.touchableNodeAtLocation(worldPosition),
                        mathNode = button.parent as? MathNode
                    where mathNode != self && mathNode.canReceiveChildren
                    {
                        dragParent = mathNode
                    }
                    else {
                        dragParent = nil
                    }
                }
            }
            else {
                dragLine.hidden = true
            }
        }
    }

}
