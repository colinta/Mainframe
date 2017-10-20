//
//  Mainframe.swift
//  Untitled
//
//  Created by Colin Gray on 4/22/2016.
//  Copyright (c) 2016 Untitled. All rights reserved.
//

private var RestoreTreeDelay: CGFloat = 3

class Mainframe: World {
    struct PanelItem: Equatable {
        let panel = Node()
        let button = Button()

        func enable() {
            button.isEnabled = true
        }

        func disabled() {
            button.isEnabled = false
            panel.fadeTo(0, rate: 3.333)
        }
    }

    struct Size {
        static let TabbarHeight: CGFloat = 50
        static let ButtonHeight: CGFloat = 50
        static var TreeOffset: CGFloat = 0
        static var ButtonY: CGFloat = -50
    }

    enum OutputStyle {
        case Exact
        case Number
    }
    var outputStyle: OutputStyle = .Exact
    let outputCalc = Button()
    let outputFormula = TextNode()

    var hasManyTopNodes: Bool {
        return topNodes.count > 1
    }
    var topNodes: [MathNode] { return tree.children.flatMap { $0 as? MathNode } }
    var topNode = MathNode() {
        willSet {
            guard newValue != topNode else { return }
            topNode._onUpdate = []
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
        outputCalc.z = .Top
        outputCalc.fixedPosition = .TopRight(x: 0, y: Size.ButtonY)
        outputCalc.alignment = .right
        outputCalc.style = .RectSized(screenSize.width, 60)
        outputCalc.borderColor = 0x0
        outputCalc.margins.top = 10
        outputCalc.margins.left = 10
        outputCalc.margins.right = 10
        outputCalc.touchableComponent?.off(.Enter)
        outputCalc.touchableComponent?.off(.Exit)
        outputCalc.onTapped {
            switch self.outputStyle {
            case .Exact:
                self.outputStyle = .Number
            case .Number:
                self.outputStyle = .Exact
            }
            self.updateCalc()
        }
        self << outputCalc

        outputFormula.z = .Top
        outputFormula.fixedPosition = .TopRight(x: 0, y: -30)
        outputFormula.margins.left = 10
        outputFormula.margins.right = 10
        outputFormula.textScale = 0.75
        outputFormula.alignment = .right
        self << outputFormula

        let outputBg = SKSpriteNode(id: .FillColorBox(size: CGSize(screenSize.width, 80), color: 0x0))
        outputBg.position = CGPoint(y: screenSize.height / 2 - 40)
        outputBg.z = .Above
        self << outputBg

        defaultNode = self
        let treeDrag = TouchableComponent()
        treeDrag.on(.Down) { _ in
            if let panel = self.panel {
                self.togglePanel(panel)
            }
        }
        treeDrag.onDragged { p1, p2 in
            self.tree.position += p2 - p1
        }
        treeDrag.on(.Tapped) { _ in
            self.currentOp = nil
        }
        self.addComponent(treeDrag)
        self << tree

        let topNode = self.topNode
        topNode.fixedPosition = .Top(x: 0, y: -160)
        tree << topNode
        Size.TreeOffset = topNode.position.y
        topNode.onUpdate(self.updateCalc)

        addButton.fixedPosition = .TopLeft(x: 5 + addButton.size.width / 2, y: -95)
        self << addButton

        let tabbarButtons = [
            ("123", numbersItem.button),
            ("±≠", operatorsItem.button),
            ("𝑓(𝑥)", functionsItem.button),
            ("𝑥𝑦𝑧", variablesItem.button),
        ]
        do {
            let buttonWidth = screenSize.width / CGFloat(tabbarButtons.count)
            var x: CGFloat = -screenSize.width / 2 + buttonWidth / 2
            for (text, button) in tabbarButtons {
                button.z = .Above
                button.text = text
                button.style = .RectSized(buttonWidth, Size.TabbarHeight)
                button.fixedPosition = .Bottom(x: x, y: Size.TabbarHeight / 2)
                x += buttonWidth
                self << button
            }
        }

        createPanel(numbersItem.panel, buttons: [
            [.Key(.Delete), .Key(.Clear), .Next],
            [.Key(.Num1), .Key(.Num2), .Key(.Num3)],
            [.Key(.Num4), .Key(.Num5), .Key(.Num6)],
            [.Key(.Num7), .Key(.Num8), .Key(.Num9)],
            [.Key(.NumDot), .Key(.Num0), .Key(.SignSwitch)]
        ])
        createPanel(operatorsItem.panel, buttons: [
            [.Operator(AddOperation()), .Operator(SubtractOperation()), .Operator(DivideOperation()), .Operator(MultiplyOperation())],
            [.Operator(SquareRootOperation()), .Operator(FactorialOperation())],
        ])
        createPanel(functionsItem.panel, buttons: [
            [.Function(LogOperation()), .Function(LnOperation()), .Function(LogNOperation())],
            [.Function(SinOperation()), .Function(CosOperation()), .Function(TanOperation())],
            [.Function(ArcSinOperation()), .Function(ArcCosOperation()), .Function(ArcTanOperation())],
        ])
        createPanel(variablesItem.panel, buttons: [
            [.Variable("𝑥"), .Assign("𝑥"), .Variable("𝑦"), .Assign("𝑦"), .Variable("𝑧"), .Assign("𝑧")],
            [.Variable("π"), .Variable("τ"), .Variable("𝑒")],
        ])

        numbersItem.button.onTapped { self.togglePanel(self.numbersItem) }
        operatorsItem.button.onTapped { self.togglePanel(self.operatorsItem) }
        functionsItem.button.onTapped { self.togglePanel(self.functionsItem) }
        variablesItem.button.onTapped { self.togglePanel(self.variablesItem) }

        currentOp = topNode
    }

    func updateTopNode() {
        for child in tree.children {
            if let child = child as? MathNode {
                topNode = child
                break
            }
        }
    }

    func updateCalc() {
        switch outputStyle {
        case .Exact:
            outputCalc.text = topNode.calculate(self).description
        case .Number:
            outputCalc.text = topNode.calculate(self).number
        }
        outputFormula.text = topNode.formula(isTop: true)
        if !outputFormula.text.contains("=") {
            outputFormula.text += "="
        }

        if outputCalc.textSize.width > self.screenSize.width {
            outputCalc.alignment = .left
            outputCalc.fixedPosition = .TopLeft(x: 0, y: Size.ButtonY)
        }
        else {
            outputCalc.alignment = .right
            outputCalc.fixedPosition = .TopRight(x: 0, y: Size.ButtonY)
        }
    }

    func willSetCurrentOp(_ newValue: MathNode?) {
        guard currentOp != newValue else { return }

        if let currentOp = currentOp, currentOp.op.isSelected {
            currentOp.op = .NoOp
        }

        let panelButtonsEnabled = newValue != nil
        for panelItem in panelItems {
            panelItem.button.isEnabled = panelButtonsEnabled
        }

        if let newOp = newValue {
            var topMost: MathNode = newOp
            while let parent = topMost.parent as? MathNode {
                topMost = parent
            }
            self.topNode = topMost

            if newOp.op.isNoOp {
                newOp.op = .NoOpSelected
                togglePanel(numbersItem, show: true)
            }

            if let panel = newOp.op.panel(mainframe: self) {
                togglePanel(panel, show: true)
            }
        }

        firstKeyPress = true
    }

    func didSetCurrentOp(_ oldValue: MathNode?) {
        oldValue?.isClearEnabled = false
        if let currentOp = currentOp {
            let clearableOp = !currentOp.op.isNoOp
            let isTopLevel = currentOp.topMostParent == currentOp
            currentOp.isClearEnabled = clearableOp || isTopLevel && hasManyTopNodes

            checkCameraLocation()
        }
        else {
            repositionTopNodes()
        }
    }

    func addTopNode(_ node: MathNode, at specificPosition: CGPoint?) {
        guard let lastTopNode = topNodes.last else { return }

        let position: CGPoint
        if let specificPosition = specificPosition {
            position = convert(specificPosition, to: tree)
        }
        else {
            position = lastTopNode.position + CGPoint(x: lastTopNode.size.width / 2 + MathNode.Size.spacing)
        }

        node.position = position
        tree << node
        currentOp = node
    }

    func createPanel(_ panel: Node, buttons: [[Operation]]) {
        let totalHeight: CGFloat = CGFloat(buttons.count) * Size.ButtonHeight
        panel.fixedPosition = .Bottom(x: 0, y: Size.TabbarHeight + totalHeight / 2)
        var y = totalHeight / 2 - Size.ButtonHeight / 2
        for ops in buttons {
            let buttonWidth = screenSize.width / CGFloat(ops.count)
            var x = -screenSize.width / 2 + buttonWidth / 2
            for op in ops {
                let button = op.asButton()
                button.z = .Above
                button.style = .RectSized(buttonWidth, Size.TabbarHeight)
                button.position = CGPoint(x, y)
                button.onTapped {
                    op.tapped(self, first: self.firstKeyPress)
                    self.firstKeyPress = false
                }
                panel << button
                x += buttonWidth
            }
            y -= Size.ButtonHeight
        }
        panel.alpha = 0
        panel.size = CGSize(screenSize.width, totalHeight)
        self << panel
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

        let opBottom: CGFloat, opLeft: CGFloat, opRight: CGFloat
        if let target = currentOp.moveToComponent?.target {
            opLeft = convertPosition(currentOp).x - currentOp.size.width / 2 + (target - currentOp.position).x
            opRight = convertPosition(currentOp).x + currentOp.size.width / 2 + (target - currentOp.position).x
            opBottom = convertPosition(currentOp).y - currentOp.size.height / 2 + (target - currentOp.position).y
        }
        else{
            opLeft = convertPosition(currentOp).x - currentOp.size.width / 2
            opRight = convertPosition(currentOp).x + currentOp.size.width / 2
            opBottom = convertPosition(currentOp).y - currentOp.size.height / 2
        }

        var moveCamera = false
        if let panel = panel?.panel {
            let panelTop = panel.position.y + panel.size.height / 2
            moveCamera ||= opBottom < panelTop
        }
        moveCamera ||= opLeft < -screenSize.width / 2
        moveCamera ||= opRight > screenSize.width / 2

        if moveCamera {
            let position = tree.convert(.zero, from: currentOp)
            tree.moveTo(-1 * position + CGPoint(y: Size.TreeOffset), duration: 0.3)
        }
    }

    func repositionTopNodes() {
        var centerX: CGFloat = 0
        var isFirst = true
        let lastNode = topNodes.last
        for node in topNodes {
            if !isFirst {
                centerX += node.size.width / 2
            }
            node.moveTo(CGPoint(x: centerX), duration: 0.3)
            if node != lastNode {
                centerX += node.size.width / 2 + MathNode.Size.spacing
            }
            isFirst = false
        }
        tree.moveTo(CGPoint(x: -centerX / 2), duration: 0.3)
        if let panel = panel {
            togglePanel(panel)
        }
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
        return .NeedsInput
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
