////
/// MathNode.swift
//

class MathNode: Node {
    struct Size {
        static let spacing: CGFloat = 15
    }

    var mainframe: Mainframe? { return world as? Mainframe }

    enum Editing {
        case number
        case numerator
        case denominator
    }
    var numberString = ""
    var numeratorString = ""
    var denominatorString = ""

    var editingSign: Sign = .positive
    var editing: Editing = .number
    var editingString: String {
        get {
            switch editing {
            case .number: return numberString
            case .numerator: return numeratorString
            case .denominator: return denominatorString
            }
        }
        set {
            switch editing {
            case .number: numberString = newValue
            case .numerator: numeratorString = newValue
            case .denominator: denominatorString = newValue
            }
        }
    }
    var editingNumberOp: Operation {
        if editing == .numerator || editing == .denominator || !numeratorString.isEmpty || !denominatorString.isEmpty {
            return .woodworking(sign: editingSign, number: numberString, numerator: numeratorString, denominator: denominatorString)
        }
        else if !numberString.isEmpty || editingSign == .negative {
            return .number(editingSign, numberString)
        }
        else {
            return .noOp
        }
    }

    private var prevOp: Operation = .noOp
    private var _op: Operation = .noOp
    var op: Operation {
        get { _op }
        set {
            prevOp = _op
            _op = newValue
            updateMathNodes()
        }
    }
    func setAndSelect(op newValue: Operation) {
        prevOp = _op
        _op = newValue
        updateMathNodes(select: true)
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
    var activeMathChildren: [MathNode] { return mathChildren.filter { $0.active && !$0.op.isEmptyOp } }
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
    var isMoving = false
    var isDragging: Bool { return dragDest != nil }
    var dragDest: CGPoint?
    let button = Button()
    var buttonTimer: CGFloat?
    private let clearButton = Button()
    private var _isClearEnabled = false {
        didSet {
            clearButton.isHidden = !_isClearEnabled
        }
    }
    var isClearEnabled: Bool {
        set {
            _isClearEnabled = newValue
            updateMathNodes()
        }
        get { return _isClearEnabled }
    }
    var active = true

    typealias OnUpdate = () -> Void
    private var _onUpdate: [OnUpdate] = []
    func onUpdate(_ handler: @escaping OnUpdate) {
        _onUpdate.append(handler)
        handler()
    }
    func offUpdate() {
        _onUpdate = []
    }

    required init() {
        super.init()

        parentLine.anchorPoint = CGPoint(0, 0.5)
        parentLine.z = .bottom
        dragLine.isHidden = true
        dragLine.anchorPoint = CGPoint(0, 0.5)
        dragLine.z = .bottom
        self << button
        self << parentLine
        self << dragLine
        self << clearButton

        jiggle.isEnabled = false
        button.borderColor = 0xffffff
        button.addComponent(jiggle)
        button.style = .squareSized(25)
        button.touchableComponent?.on(.down) { _ in
            self.isMoving = false
            self.buttonTimer = 0.5
        }
        button.touchableComponent?.on(.up) { _ in
            if let dragParent = self.dragParent, self.dragParent != self.parent
            {
                let oldParent = self.parent as? MathNode
                let position = dragParent.convertPosition(self)
                self.move(toParent: dragParent)
                self.position = position
                self.mainframe?.topNode = self.topMostParent
                dragParent.updateMathNodes()
                oldParent?.updateMathNodes()
            }

            self.isMoving = false
            self.buttonTimer = nil
            self.jiggle.isEnabled = false
            self.button.zRotation = 0
            self.dragLine.isHidden = true
            self.dragDest = nil
            self.dragParent = nil
        }

        button.touchableComponent?.on(.dragBegan) { pt in
            if !self.isMoving && !self.op.mustBeTop {
                self.buttonTimer = nil
                self.dragDest = pt
            }
        }
        button.touchableComponent?.on(.dragMoved) { pt in
            if self.isMoving {
                self.position += pt
            }
            else if self.isDragging {
                self.dragDest = pt
            }
        }
        button.onTapped {
            self.mainframe?.currentMathNode = self
        }

        clearButton.isHidden = true
        clearButton.style = .circleSized(20)
        clearButton.color = 0x0
        clearButton.borderColor = 0xFFFFFF
        clearButton.backgroundColor = 0xFFFFFF
        clearButton.text = "×"
        clearButton.textScale = 0.75
        clearButton.position = CGPoint(x: 25)
        clearButton.onTapped {
            guard let mainframe = self.mainframe else { return }

            if self.op.isEmptyOp && self.topMostParent == self && mainframe.hasManyTopNodes {
                self.removeFromParent()
                mainframe.selectAnyTopNode()
                return
            }

            for node in self.mathChildren {
                if mainframe.currentMathNode == node {
                    mainframe.currentMathNode = self
                }
                node.removeFromParent()
            }

            self._isClearEnabled = false
            self.editing = .number
            self.op = .noOp
        }

        updateSize([])
    }

    override func insertChild(_ node: SKNode, at index: Int) {
        var newIndex = index
        if let node = node as? MathNode, index == children.count && !node.op.isEmptyOp
        {
            newIndex = 0
            for (childIndex, child) in children.enumerated() {
                if let child = child as? MathNode, !child.op.isEmptyOp {
                    newIndex = childIndex + 1
                }
            }
        }
        super.insertChild(node, at: newIndex)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func reset() {
        super.reset()
        _onUpdate = []
    }

    func formula(isTop: Bool = false) -> String {
        return op.formula(activeMathChildren, isTop: isTop)
    }

    func calculate(vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        return op.calculate(activeMathChildren, vars: vars, avoidRecursion: avoidRecursion)
    }

    func updateMathNodes(select: Bool = false) {
        let isCurrentOp = mainframe?.currentMathNode == self
        let childIsCurrentOp = isCurrentOp || mainframe?.currentMathNode?.parent == self

        switch op {
        case .noOp:
            button.text = ""
            button.style = .squareSized(isCurrentOp ? 50 : 25)
        case .number, .woodworking:
            let text: String
            if isCurrentOp {
                text = op.description(editing: editing)
            }
            else {
                text = op.description
            }
            button.text = text
            button.style = text.isEmpty ? .squareSized(isCurrentOp ? 50 : 25) : .rectToFit
        default:
            button.text = op.treeDescription
            button.style = .rectToFit
        }

        button.textScale = isCurrentOp ? 1.5 : 1
        clearButton.position = CGPoint(x: button.size.width / 2 + 5 + clearButton.size.width / 2)

        var visibleNodes: [MathNode] = mathChildren
        var selectNode: MathNode?

        if let minCount = op.minChildNodes {
            if mathChildren.count < minCount {
                (minCount - mathChildren.count).times { (i: Int) in
                    let node = generateNode(usePrev: true)
                    self << node
                    visibleNodes << node
                    if node.op.isEmptyOp && selectNode == nil {
                        selectNode = node
                    }
                }
            }
        }

        if !op.isEmptyOp {
            if let maxCount = op.maxChildNodes {
                if mathChildren.count > maxCount {
                    for node in mathChildren[maxCount..<mathChildren.count] {
                        node.fadeTo(0, duration: 0.3, removeNode: node.op.isEmptyOp)
                        node.active = false
                    }
                }
                visibleNodes = Array(mathChildren[0..<maxCount])
            }
            else if childIsCurrentOp && mathChildren.all({ !$0.op.isEmptyOp }) {
                let node = generateNode(usePrev: false)
                self << node
                visibleNodes << node
                if node.op.isEmptyOp && selectNode == nil {
                    selectNode = node
                }
            }
            else if !childIsCurrentOp {
                for node in visibleNodes {
                    guard node.op.isEmptyOp else { continue }
                    node.fadeTo(0, duration: 0.3, removeNode: true)
                    node.active = false
                }
                visibleNodes = visibleNodes.filter { !$0.op.isEmptyOp }
            }
        }

        updateSize(visibleNodes)

        if visibleNodes.count > 0 {
            let totalWidth = self.size.width - (Size.spacing + (isClearEnabled ? 5 + clearButton.size.width : 0))
            var x = -totalWidth / 2
            let y: CGFloat = -60
            for node in visibleNodes {
                node.active = true
                if node.alpha < 1 {
                    node.fadeTo(1, rate: 3.3)
                }

                let position = CGPoint(x + node.size.width / 2, y)
                node.moveTo(position, duration: 0.3)
                x += node.size.width + Size.spacing
            }
        }

        switch op {
        case .number, .woodworking: break
        default:
            numberString = ""
            numeratorString = ""
            denominatorString = ""
        }

        (parent as? MathNode)?.updateMathNodes()

        for handler in _onUpdate {
            handler()
        }

        if let selectNode = selectNode, isCurrentOp && select {
            mainframe?.currentMathNode = selectNode
        }
    }

    private func updateSize(_ visibleNodes: [Node]) {
        let totalWidth = visibleNodes.reduce(CGFloat(0)) { $0 + $1.size.width + Size.spacing }
        size = CGSize(
            width: max(totalWidth, button.size.width) + (isClearEnabled ? 5 + clearButton.size.width : 0),
            height: 50
        )
    }

    private func generateNode(usePrev: Bool) -> MathNode {
        let node = MathNode()
        node.alpha = 0
        if usePrev {
            switch prevOp {
            case .number, .woodworking:
                node.numberString = numberString
                node.numeratorString = numeratorString
                node.denominatorString = denominatorString
                node.op = prevOp
            case .variable:
                node.op = prevOp
            default: break
            }
        }
        prevOp = .noOp
        numberString = ""
        return node
    }

    override func update(_ dt: CGFloat) {
        if let buttonTimer = buttonTimer {
            self.buttonTimer = buttonTimer - dt
        }

        if parent is MathNode {
            parentLine.isHidden = false
            parentLine.zRotation = TAU_2 + position.angle
            parentLine.textureId(.colorLine(length: position.length, color: 0xFFFFFF))

            if let buttonTimer = buttonTimer,
                buttonTimer <= 0,
                let mainframe = self.mainframe
            {
                let oldParent = self.parent as? MathNode
                let treePosition = mainframe.tree.convert(.zero, from: self)
                self.move(toParent: mainframe.tree)
                self.position = treePosition
                mainframe.topNode = self
                self.updateMathNodes()
                oldParent?.updateMathNodes()
            }
        }
        else {
            parentLine.isHidden = true

            if let buttonTimer = buttonTimer, buttonTimer <= 0 {
                self.buttonTimer = nil
                self.isMoving = true
                self.jiggle.isEnabled = true
            }

            if let dragDest = dragDest {
                dragLine.isHidden = false
                dragLine.zRotation = dragDest.angle
                dragLine.textureId(.colorLine(length: dragDest.length, color: 0xFFFFFF))

                if let world = world {
                    let worldPosition = world.convert(dragDest, from: self)
                    if let button = world.touchableNodeAtLocation(worldPosition),
                        let mathNode = button.parent as? MathNode,
                        mathNode != self && mathNode.canReceiveChildren
                    {
                        dragParent = mathNode
                    }
                    else {
                        dragParent = nil
                    }
                }
            }
            else {
                dragLine.isHidden = true
            }
        }
    }

}
