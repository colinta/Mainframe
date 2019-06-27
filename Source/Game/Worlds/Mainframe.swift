////
/// Mainframe.swift
//

private var RestoreTreeDelay: CGFloat = 3

class Mainframe: World {
    struct PanelItem: Equatable {
        let panel = Node()
        let button: Button = {
            let button = Button()
            button.borderColor = 0xffffff
            return button
        }()

        func enable() {
            button.isEnabled = true
        }

        func disabled() {
            button.isEnabled = false
            panel.fadeTo(0, rate: 3.333)
        }
    }

    struct Size {
        static let tabbarHeight: CGFloat = 50
        static let buttonY: CGFloat = -50
        static let formulaBgHeight: CGFloat = 80
        static let formulaHeight: CGFloat = 60
        static let expandSize: CGFloat = 40
        static let newNodeSpacing: CGFloat = 50

        static var treeOffset: CGFloat = 0
    }

    enum OutputStyle {
        case exact
        case number
    }

    var remainingScreenSize: CGSize { return CGSize(width: screenSize.width, height: screenSize.height - Size.formulaBgHeight - Size.tabbarHeight) }

    var outputStyle: OutputStyle = .exact
    let outputCalc = Button()
    let outputFormula = TextNode()
    let expandButton = Button()

    var hasManyTopNodes: Bool {
        return topNodes.count > 1
    }
    var topNodes: [MathNode] { return tree.children.compactMap { $0 as? MathNode } }
    var topNode = MathNode() {
        willSet {
            guard newValue != topNode else { return }
            topNode.offUpdate()
            newValue.onUpdate(self.updateCalc)
            updateCalc()
        }
    }
    let tree = Node()
    var currentOp: MathNode? {
        willSet { willSetCurrentOp(newValue) }
        didSet { didSetCurrentOp(oldValue) }
    }
    var firstKeyPress = true

    let addButton = AddButton()

    var panel: PanelItem?
    let numbersItem = PanelItem()
    let operatorsItem = PanelItem()
    let functionsItem = PanelItem()
    let variablesItem = PanelItem()
    var panelItems: [PanelItem] { return [numbersItem, operatorsItem, functionsItem, variablesItem] }

    required init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func populateWorld() {
        let treeDrag = TouchableComponent()
        treeDrag.on(.down) { _ in
            self.hidePanel()
        }
        treeDrag.onDragged { p1, p2 in
            self.tree.position += p2 - p1
        }
        treeDrag.on(.tapped) { _ in
            self.currentOp = nil
        }
        self.addComponent(treeDrag)
        defaultNode = self

        outputCalc.z = .top
        outputCalc.fixedPosition = .topRight(x: 0, y: Size.buttonY)
        outputCalc.alignment = .right
        outputCalc.style = .rectSized(remainingScreenSize.width, Size.formulaHeight)
        outputCalc.borderColor = 0x0
        outputCalc.margins.top = 10
        outputCalc.margins.left = 10
        outputCalc.margins.right = 10
        outputCalc.touchableComponent?.off(.enter, .exit)
        outputCalc.onTapped {
            switch self.outputStyle {
            case .exact:
                self.outputStyle = .number
            case .number:
                self.outputStyle = .exact
            }
            self.updateCalc()
        }
        self << outputCalc

        outputFormula.z = .top
        outputFormula.fixedPosition = .topRight(x: 0, y: -30)
        outputFormula.margins.left = 10
        outputFormula.margins.right = 10
        outputFormula.textScale = 0.75
        outputFormula.alignment = .right
        self << outputFormula

        let expandSprite = SKSpriteNode(id: .expand)
        expandSprite.z = .above
        expandButton << expandSprite
        expandButton.style = .squareSized(Size.expandSize)
        expandButton.backgroundColor = 0x0
        expandButton.borderColor = 0xFFFFFF
        expandButton.fixedPosition = .bottomRight(x: -Size.expandSize / 2, y: Size.tabbarHeight + Size.expandSize / 2)
        expandButton.onTapped {
            self.expandToExtents()
        }
        self << expandButton

        let outputBg = SKSpriteNode(id: .fillColorBox(size: CGSize(remainingScreenSize.width, Size.formulaBgHeight), color: 0x0))
        outputBg.position = CGPoint(y: screenSize.height / 2 - 40)
        outputBg.z = .above
        self << outputBg

        self << tree

        topNode.fixedPosition = .top(x: 0, y: -160)
        tree << topNode

        Size.treeOffset = topNode.position.y
        topNode.onUpdate(self.updateCalc)

        addButton.fixedPosition = .topLeft(x: 5 + addButton.size.width / 2, y: -95)
        self << addButton

        let tabbarButtons = [
            ("123", numbersItem.button),
            ("±", operatorsItem.button),
            ("𝑓(𝑥)", functionsItem.button),
            ("𝑥𝑦𝑧=", variablesItem.button),
        ]
        do {
            let buttonWidth = remainingScreenSize.width / CGFloat(tabbarButtons.count)
            var x: CGFloat = -remainingScreenSize.width / 2 + buttonWidth / 2
            for (text, button) in tabbarButtons {
                button.z = .above
                button.text = text
                button.style = .rectSized(buttonWidth, Size.tabbarHeight)
                button.fixedPosition = .bottom(x: x, y: Size.tabbarHeight / 2)
                x += buttonWidth
                self << button
            }
        }

        createPanel(numbersItem.panel, buttons: [
            [.key(.delete), .key(.clear), .nxttt],
            [.key(.num1), .key(.num2), .key(.num3)],
            [.key(.num4), .key(.num5), .key(.num6)],
            [.key(.num7), .key(.num8), .key(.num9)],
            [.key(.dot), .key(.num0), .key(.sign)]
        ])
        createPanel(operatorsItem.panel, buttons: [
            [.operator(AddOperation()), .operator(SubtractOperation()), .operator(DivideOperation()), .operator(MultiplyOperation())],
            [.operator(SquareRootOperation()), .operator(NRootOperation()), .operator(ExponentOperation()), .operator(FactorialOperation())],
        ])
        createPanel(functionsItem.panel, buttons: [
            [.function(LogOperation()), .function(LnOperation()), .function(LogNOperation())],
            [.function(SinOperation()), .function(CosOperation()), .function(TanOperation())],
            [.function(ArcSinOperation()), .function(ArcCosOperation()), .function(ArcTanOperation())],
        ])
        createPanel(variablesItem.panel, buttons: [
            [.variable("𝑥"), .assign("𝑥"), .variable("𝑦"), .assign("𝑦"), .variable("𝑧"), .assign("𝑧"), .variable("n"), .assign("n")],
            [.variable("π"), .variable("τ"), .variable("𝑒")],
        ])

        numbersItem.button.onTapped { self.togglePanel(self.numbersItem) }
        operatorsItem.button.onTapped { self.togglePanel(self.operatorsItem) }
        functionsItem.button.onTapped { self.togglePanel(self.functionsItem) }
        variablesItem.button.onTapped { self.togglePanel(self.variablesItem) }

        currentOp = topNode
    }

    func selectAnyTopNode() {
        for child in tree.children {
            if let child = child as? MathNode {
                topNode = child
                break
            }
        }
    }

    func updateCalc() {
        switch outputStyle {
        case .exact:
            outputCalc.text = topNode.calculate(self).description
        case .number:
            outputCalc.text = topNode.calculate(self).number
        }
        outputFormula.text = topNode.formula(isTop: true)
        if !outputFormula.text.contains("=") {
            outputFormula.text += "="
        }

        if outputCalc.textSize.width > self.remainingScreenSize.width {
            outputCalc.alignment = .left
            outputCalc.fixedPosition = .topLeft(x: 0, y: Size.buttonY)
        }
        else {
            outputCalc.alignment = .right
            outputCalc.fixedPosition = .topRight(x: 0, y: Size.buttonY)
        }
    }

    func willSetCurrentOp(_ newValue: MathNode?) {
        guard currentOp != newValue else { return }

        if let currentOp = currentOp, currentOp.op.isSelected {
            currentOp.op = .noOp(isSelected: false)
        }

        let panelButtonsEnabled = newValue != nil
        for panelItem in panelItems {
            panelItem.button.isEnabled = panelButtonsEnabled
        }

        if !panelButtonsEnabled {
            hidePanel()
        }

        firstKeyPress = true
    }

    func didSetCurrentOp(_ oldValue: MathNode?) {
        oldValue?.isClearEnabled = false
        if let currentOp = currentOp {
            var topMost: MathNode = currentOp
            while let parent = topMost.parent as? MathNode {
                topMost = parent
            }
            self.topNode = topMost

            if currentOp.op.isNoOp {
                currentOp.op = .noOp(isSelected: true)
                togglePanel(numbersItem, show: true)
            }

            if let panel = currentOp.op.panel(mainframe: self) {
                togglePanel(panel, show: true)
            }

            let clearableOp = !currentOp.op.isNoOp
            let isTopLevel = currentOp.topMostParent == currentOp
            currentOp.isClearEnabled = clearableOp || isTopLevel && hasManyTopNodes

            checkCameraLocation()
        }
    }

    func addTopNode(_ node: MathNode, at specificPosition: CGPoint?) {
        guard let lastTopNode = topNodes.last else { return }

        let position: CGPoint
        if let specificPosition = specificPosition {
            position = convert(specificPosition, to: tree)
        }
        else {
            position = lastTopNode.position + CGPoint(x: lastTopNode.size.width / 2 + Size.newNodeSpacing)
        }

        node.position = position
        tree << node
        currentOp = node
    }

    func createPanel(_ panel: Node, buttons: [[Operation]]) {
        let totalHeight: CGFloat = CGFloat(buttons.count) * Size.tabbarHeight
        panel.fixedPosition = .bottom(x: 0, y: Size.tabbarHeight + totalHeight / 2)
        var y = totalHeight / 2 - Size.tabbarHeight / 2
        for ops in buttons {
            let buttonWidth = remainingScreenSize.width / CGFloat(ops.count)
            var x = -remainingScreenSize.width / 2 + buttonWidth / 2
            for op in ops {
                let button = op.asButton()
                button.z = .above
                button.style = .rectSized(buttonWidth, Size.tabbarHeight)
                button.position = CGPoint(x, y)
                button.onTapped {
                    op.tapped(self, isFirst: self.firstKeyPress)
                    self.firstKeyPress = false
                }
                panel << button
                x += buttonWidth
            }
            y -= Size.tabbarHeight
        }
        panel.alpha = 0
        panel.size = CGSize(remainingScreenSize.width, totalHeight)
        self << panel
    }

    func hidePanel() {
        guard let panel = panel else { return }
        togglePanel(panel)
    }

    func togglePanel(_ nextPanel: PanelItem, show: Bool? = nil) {
        if show == true && panel == nextPanel { return }

        panel?.panel.fadeTo(0, duration: 0.3)

        if let button = panel?.button {
            button.color = 0xFFFFFF
            button.backgroundColor = 0x0
            button.borderColor = 0xFFFFFF
        }

        if panel == nextPanel {
            panel = nil
        }
        else {
            nextPanel.panel.fadeTo(1, duration: 0.3)

            let button = nextPanel.button
            button.color = 0x0
            button.backgroundColor = 0xFFFFFF
            button.borderColor = 0xFFFFFF

            for node in nextPanel.panel.children {
                if let button = node as? OperationButton {
                    button.isEnabled = button.op.compatible(mainframe: self)
                }
            }

            panel = nextPanel

            checkCameraLocation()
        }
    }

    func checkCameraLocation() {
        guard let currentOp = currentOp else { return }

        let currentPosition: CGPoint
        if let target = currentOp.moveToComponent?.target, let currentParent = currentOp.parent {
            currentPosition = convert(target, from: currentParent)
        }
        else {
            currentPosition = convertPosition(currentOp)
        }

        let currentSize = currentOp.button.size
        let opLeft = currentPosition.x - currentSize.width / 2
        let opRight = currentPosition.x + currentSize.width / 2
        let opBottom = currentPosition.y - currentSize.height / 2
        let opTop = currentPosition.y + currentSize.height / 2

        var screenRect = CGRect(
            x: -remainingScreenSize.width / 2,
            y: -screenSize.height / 2 + Size.tabbarHeight,
            width: remainingScreenSize.width,
            height: remainingScreenSize.height
        )

        var moveX: CGFloat?
        var moveY: CGFloat?
        let margin: CGFloat = 5
        let rightMargin: CGFloat = 25

        if let panel = panel?.panel {
            let panelTop = panel.position.y + panel.size.height / 2
            screenRect.origin.y = panelTop
            screenRect.size.height -= panel.size.height
        }

        if opBottom < screenRect.minY {
            moveY = screenRect.minY - opBottom + margin
        }
        else if opTop > screenRect.maxY {
            moveY = screenRect.maxY - opTop - margin
        }

        if opLeft < screenRect.minX {
            moveX = screenRect.minX - opLeft + margin
        }
        else if opRight > screenRect.maxX {
            moveX = screenRect.maxX - opRight - rightMargin
        }

        if moveX != nil || moveY != nil {
            let delta = CGPoint(x: moveX ?? 0, y: moveY ?? 0)
            let position = tree.position + delta
            tree.moveTo(position, duration: 0.3)
        }
    }

    func expandToExtents() {
        currentOp = nil
        hidePanel()

        var extents: CGRect?
        for node in topNodes {
            let nodeRect = CGRect(center: tree.convertPosition(node), size: node.calculateAccumulatedFrame().size)
            if let prevExtents = extents {
                extents = prevExtents.union(nodeRect)
            }
            else {
                extents = nodeRect
            }
        }

        if let extents = extents {
            let insets: CGFloat = 10

            let yCorrection = (Size.tabbarHeight - Size.formulaBgHeight) / 2
            let scaleX = (remainingScreenSize.width - insets) / extents.width
            let scaleY = (remainingScreenSize.height - insets) / extents.height
            let scale = min(1, scaleX, scaleY)
            let treePosition = CGPoint(x: -extents.center.x * scale, y: -extents.center.y * scale + yCorrection)
            tree.scaleTo(scale, duration: 0.2)
            tree.moveTo(treePosition, duration: 0.2)

            if scale < 1 {
                let zoomButton = Node()
                let touchableComponent = TouchableComponent()
                touchableComponent.on(.upInside) { location in
                    self.tree.scaleTo(1, duration: 0.2)
                    self.tree.moveTo(CGPoint(x: -location.x / scale, y: -location.y / scale), duration: 0.2)
                    zoomButton.removeFromParent()
                }
                touchableComponent.containsTouchTest = TouchableComponent.defaultTouchTest()
                zoomButton.addComponent(touchableComponent)
                zoomButton.size = CGSize(width: remainingScreenSize.width, height: remainingScreenSize.height)
                zoomButton.z = .top
                zoomButton.position.y = yCorrection
                self << zoomButton
            }
        }
    }

    override func worldShook() {
         repositionTopNodes()
    }

    func repositionTopNodes() {
        let yCorrection = (Size.tabbarHeight - Size.formulaBgHeight) / 2
        let totalWidth = (topNodes.reduce(CGFloat(0)) { memo, node in
            let nodeSize = node.calculateAccumulatedFrame().size
            return memo + nodeSize.width
        }) + CGFloat(topNodes.count - 1) * Size.newNodeSpacing

        var centerX = -totalWidth / 2
        let sortedNodes = topNodes.sorted { a, b in
            return a.position.x < b.position.x
        }
        for node in sortedNodes {
            let nodeSize = node.calculateAccumulatedFrame().size
            centerX += nodeSize.width / 2
            node.moveTo(CGPoint(x: centerX), duration: 0.3)
            centerX += nodeSize.width / 2 + Size.newNodeSpacing
        }

        tree.moveTo(CGPoint(x: 0, y: yCorrection), duration: 0.3)
        hidePanel()
    }

}

protocol VariableLookup {
    func valueForVariable(_ name: String) -> OperationResult
}

extension Mainframe: VariableLookup {
    func valueForVariable(_ name: String) -> OperationResult {
        for child in tree.children {
            if let child = child as? MathNode, child.op.isVariable(name) {
                return child.calculate(self)
            }
        }
        return .needsInput
    }
}

func ==(lhs: Mainframe.PanelItem, rhs: Mainframe.PanelItem) -> Bool {
    return lhs.panel == rhs.panel
}

infix operator ||= : AssignmentPrecedence

infix operator &&= : AssignmentPrecedence

func ||=(lhs: inout Bool, rhs: Bool) {
    lhs = lhs || rhs
}

func &&=(lhs: inout Bool, rhs: Bool) {
    lhs = lhs && rhs
}
