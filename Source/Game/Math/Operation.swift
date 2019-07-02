////
/// Operation.swift
//

enum Operation {
    case nextBlankOp
    case key(KeyCode)

    case number(Sign, String)
    case woodworking(sign: Sign, number: String, numerator: String, denominator: String)
    case variable(String)
    case assign(String)

    case `operator`(OperationValue)
    case function(OperationValue)

    case noOp

    var isEmptyOp: Bool {
        switch self {
        case .noOp: return true
        case let .number(_, num): return num.isEmpty
        case let .woodworking(_, num, numer, denom): return num.isEmpty && numer.isEmpty && denom.isEmpty
        default: return false
        }
    }

    var isNumber: Bool {
        switch self {
        case .number, .woodworking: return true
        default: return false
        }
    }

    func isVariableAssignment(_ name: String) -> Bool {
        switch self {
        case let .assign(varName):
            return name == varName
        default:
            return false
        }
    }

    func compatible(mainframe: Mainframe) -> Bool {
        switch self {
        case let .assign(name):
            for node in mainframe.topNodes {
                if node.op.isVariableAssignment(name) {
                    return false
                }
            }
            return mainframe.currentMathNode == mainframe.topNode
        case let .variable(name):
            if var ancestor = mainframe.currentMathNode {
                while let parent = ancestor.parent as? MathNode {
                    if parent.op.isVariableAssignment(name) { return false }
                    ancestor = parent
                }
            }
            return true
        default:
            return true
        }
    }

    func panel(mainframe: Mainframe) -> Mainframe.PanelItem? {
        switch self {
        case .operator:
            return mainframe.operatorsItem
        case .variable, .assign:
            return mainframe.variablesItem
        case .number:
            return mainframe.numbersItem
        case .woodworking:
            return mainframe.woodworkingItem
        case .function:
            return mainframe.functionsItem
        default:
            return nil
        }
    }
}

extension Operation {
    var opValue: OperationValue {
        switch self {
        case let .key(key):      return KeyOperation(op: key)
        case .nextBlankOp:       return NextOperation()
        case let .number(sign, num):   return NumberOperation(sign * num)
        case let .woodworking(sign, number, numerator, denominator): return WoodworkingOperation(sign, number, numerator: numerator, denominator: denominator)
        case let .variable(num): return VariableOperation(num)
        case let .assign(num):   return AssignOperation(num)
        case let .operator(op):  return op
        case let .function(fn):  return fn
        default:                return NoOperation()
        }
    }
}

extension Operation: OperationValue {
    func formula(_ nodes: [MathNode], isTop: Bool) -> String { return opValue.formula(nodes, isTop: isTop) }
    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult { return opValue.calculate(nodes, vars: vars, avoidRecursion: avoidRecursion) }
    var mustBeTop: Bool { return opValue.mustBeTop }
    var minChildNodes: Int? { return opValue.minChildNodes }
    var maxChildNodes: Int? { return opValue.maxChildNodes }
    var description: String { return opValue.description }
    var treeDescription: String { return opValue.treeDescription }
    func description(editing: MathNode.Editing) -> String {
        opValue.description(editing: editing)
    }
}

extension Operation {
    private func findNextOp(_ currentMathNode: MathNode, mainframe: Mainframe, checkParent: Bool = true, skip: MathNode? = nil) -> MathNode? {
        if currentMathNode.op.isEmptyOp && currentMathNode != skip {
            return currentMathNode
        }

        for child in currentMathNode.mathChildren {
            if child == skip { continue }
            if let nextOp = findNextOp(child, mainframe: mainframe, checkParent: false) {
                return nextOp
            }
        }

        if let parent = currentMathNode.parent as? MathNode, checkParent {
            return findNextOp(parent, mainframe: mainframe, skip: currentMathNode)
        }
        return nil
    }

    func tapped(_ mainframe: Mainframe, currentMathNode: MathNode, isResetting: Bool) {
        switch self {
        case .nextBlankOp:
            let nextNode = findNextOp(currentMathNode, mainframe: mainframe, skip: currentMathNode)
            mainframe.currentMathNode = nextNode
            if let nextNode = nextNode {
                if currentMathNode.editing == .number {
                    nextNode.editing = .number
                    mainframe.showNumbersPanel()
                }
                else {
                    nextNode.editing = .numerator
                    mainframe.showWoodworkingPanel()
                }
                nextNode.op = nextNode.editingNumberOp
            }
            mainframe.checkCameraLocation()
        case .variable:
            let copyNumber: Bool
            if case .number = currentMathNode.op {
                copyNumber = true
            }
            else if case .woodworking = currentMathNode.op {
                copyNumber = true
            }
            else {
                copyNumber = false
            }

            if copyNumber {
                let numberNode = MathNode()
                numberNode.numberString = currentMathNode.numberString
                numberNode.numeratorString = currentMathNode.numeratorString
                numberNode.denominatorString = currentMathNode.denominatorString
                numberNode.op = currentMathNode.op
                currentMathNode << numberNode

                let variableNode = MathNode()
                variableNode.op = self
                currentMathNode << variableNode
                currentMathNode.op = .operator(MultiplyOperation())
            }
            else {
                currentMathNode.op = self
            }
        case let .key(keyCode):
            switch keyCode {
            case .swapFraction:
                if currentMathNode.editing == .numerator {
                    currentMathNode.editing = .denominator
                }
                else {
                    currentMathNode.editing = .numerator
                }
                mainframe.updateEditingButtons()
                mainframe.shouldResetNumber()
                currentMathNode.op = currentMathNode.editingNumberOp
            case .delete:
                var string = currentMathNode.editingString
                if !string.isEmpty {
                    string = string.removeFirst()
                }
                else if currentMathNode.editing == .number && currentMathNode.editingSign == .negative {
                    currentMathNode.editingSign = .positive
                }
                currentMathNode.editingString = string
                currentMathNode.op = currentMathNode.editingNumberOp
            case .clear:
                if currentMathNode.editing == .number {
                    if currentMathNode.numberString.isEmpty {
                        currentMathNode.numeratorString = ""
                        currentMathNode.denominatorString = ""
                    }
                    currentMathNode.numberString = ""
                    if currentMathNode.numeratorString.isEmpty && currentMathNode.denominatorString.isEmpty {
                        currentMathNode.editingSign = .positive
                        currentMathNode.op = .noOp
                    }
                    else {
                        currentMathNode.op = currentMathNode.editingNumberOp
                    }
                }
                else if (currentMathNode.editing == .numerator || currentMathNode.editing == .denominator) && (!currentMathNode.numeratorString.isEmpty || !currentMathNode.denominatorString.isEmpty) {
                    currentMathNode.numeratorString = ""
                    currentMathNode.denominatorString = ""
                    currentMathNode.editing = .numerator
                    currentMathNode.op = currentMathNode.editingNumberOp
                    mainframe.updateEditingButtons()
                }
                else {
                    currentMathNode.editing = .number
                    currentMathNode.numeratorString = ""
                    currentMathNode.denominatorString = ""
                    currentMathNode.op = currentMathNode.editingNumberOp
                    mainframe.showNumbersPanel()
                }
            case .dot:
                guard currentMathNode.editing == .number else { return }

                if isResetting {
                    currentMathNode.numberString = "0."
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
                else {
                    var string = currentMathNode.numberString
                    if !string.contains(".") {
                        string += keyCode.string
                        if string == "." {
                            string = "0."
                        }
                    }
                    currentMathNode.numberString = string
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
            case .sign:
                if case .variable("π") = currentMathNode.op {
                    currentMathNode.op = .variable("-π")
                }
                else if case .variable("-π") = currentMathNode.op {
                    currentMathNode.op = .variable("π")
                }
                else if case .variable("τ") = currentMathNode.op {
                    currentMathNode.op = .variable("-τ")
                }
                else if case .variable("-τ") = currentMathNode.op {
                    currentMathNode.op = .variable("τ")
                }
                else {
                    currentMathNode.editingSign = -currentMathNode.editingSign
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
            case .num1, .num2, .num3, .num4, .num5,
                 .num6, .num7, .num8, .num9, .num0:
                if isResetting {
                    currentMathNode.editingString = keyCode.string
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
                else {
                    var string = currentMathNode.editingString
                    while string.hasPrefix("0") {
                        string = string.removeFirst()
                    }
                    string += keyCode.string
                    if string.hasPrefix(".") {
                        string = "0" + string
                    }
                    currentMathNode.editingString = string
                    currentMathNode.op = currentMathNode.editingNumberOp
            }
                }
        default:
            currentMathNode.setAndSelect(op: self)
            if mainframe.currentMathNode != currentMathNode {
                mainframe.showNumbersPanel()
            }
        }
    }
}

extension Operation {
    func asButton() -> OperationButton {
        let node = OperationButton(op: self)
        node.text = description
        return node
    }
}
