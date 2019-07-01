////
/// Operation.swift
//

enum Operation {
    case nextBlankOp
    case key(KeyCode)

    case number(String)
    case woodworking(number: String, numerator: String, denominator: String)
    case variable(String)
    case assign(String)

    case `operator`(OperationValue)
    case function(OperationValue)

    case noOp(isSelected: Bool)

    var isNoOp: Bool {
        switch self {
        case .noOp: return true
        default: return false
        }
    }

    var isSelectedNoOp: Bool {
        switch self {
        case let .noOp(isSelected): return isSelected
        default: return false
        }
    }

    var isNumber: Bool {
        switch self {
        case .number, .woodworking: return true
        default: return false
        }
    }

    func isVariable(_ name: String) -> Bool {
        switch self {
        case let .assign(varName):
            return name == varName
        default:
            return false
        }
    }

    func compatible(mainframe: Mainframe) -> Bool {
        switch self {
        case .assign:
            return mainframe.currentMathNode == mainframe.topNode
        case let .variable(name):
            if var ancestor = mainframe.currentMathNode {
                while let parent = ancestor.parent as? MathNode {
                    if parent.op.isVariable(name) { return false }
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
        case let .number(num):   return NumberOperation(num)
        case let .woodworking(number, numerator, denominator): return WoodworkingOperation(number, numerator: numerator, denominator: denominator)
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
}

extension Operation {
    private func findNextOp(_ currentMathNode: MathNode, mainframe: Mainframe, checkParent: Bool = true, skip: MathNode? = nil) -> MathNode? {
        if currentMathNode.op.isNoOp && currentMathNode != skip {
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
            mainframe.currentMathNode = findNextOp(currentMathNode, mainframe: mainframe, skip: currentMathNode)
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
            case .numerator:
                currentMathNode.editing = .numerator
                mainframe.updateEditingButtons()
            case .denominator:
                currentMathNode.editing = .denominator
                mainframe.updateEditingButtons()
            case .delete:
                var string = currentMathNode.numberString
                if !string.isEmpty {
                    string = String(string[string.startIndex..<string.index(before: string.endIndex)])
                }
                currentMathNode.numberString = string
                if string == "" {
                    currentMathNode.op = .noOp(isSelected: true)
                }
                else {
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
            case .clear:
                currentMathNode.numberString = ""
                currentMathNode.numeratorString = ""
                currentMathNode.denominatorString = ""
                currentMathNode.op = .noOp(isSelected: true)
            case .dot:
                if isResetting {
                    currentMathNode.numberString = "0."
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
                else {
                    var string = currentMathNode.numberString
                    if !string.contains(".") {
                        string += keyCode.string
                        if string == "-." {
                            string = "-0."
                        }
                    }
                    currentMathNode.numberString = string
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
            case .num1, .num2, .num3, .num4, .num5,
                 .num6, .num7, .num8, .num9, .num0:
                if isResetting {
                    currentMathNode.numberString = keyCode.string
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
                else {
                    var string = currentMathNode.numberString
                    while string.hasPrefix("0") {
                        string = string.removeFirst()
                    }
                    while string.hasPrefix("-0") {
                        string = "-" + string.removeFirst().removeFirst()
                    }
                    string += keyCode.string
                    if string.hasPrefix(".") {
                        string = "0" + string
                    }
                    else if string.hasPrefix("-.") {
                        string = "-0" + string.removeFirst()
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

                var string = currentMathNode.numberString
                if !string.isEmpty {
                    if string.hasPrefix("-") {
                        string = string.removeFirst()
                    }
                    else if string.hasPrefix(".") {
                        string = "-0" + string
                    }
                    else {
                        string = "-" + string
                    }
                    currentMathNode.numberString = string
                    currentMathNode.op = currentMathNode.editingNumberOp
                }
            }
        default:
            currentMathNode.op = self
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
