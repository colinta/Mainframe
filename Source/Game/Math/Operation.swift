////
/// Operation.swift
//

enum Operation {
    case nxttt
    case key(KeyCode)

    case number(String)
    case variable(String)
    case assign(String)

    case `operator`(OperationValue)
    case function(OperationValue)

    case noOp(isSelected: Bool)

    var isNoOp: Bool {
        switch self {
        case .noOp(_): return true
        default: return false
        }
    }

    var isSelected: Bool {
        switch self {
        case let .noOp(isSelected): return isSelected
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
            return mainframe.currentOp == mainframe.topNode
        case let .variable(name):
            if var ancestor = mainframe.currentOp {
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
        case .nxttt:              return NextOperation()
        case let .number(num):   return NumberOperation(num)
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
    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult { return opValue.calculate(nodes, vars: vars) }
    var mustBeTop: Bool { return opValue.mustBeTop }
    var minChildNodes: Int? { return opValue.minChildNodes }
    var maxChildNodes: Int? { return opValue.maxChildNodes }
    var description: String { return opValue.description }
    var treeDescription: String { return opValue.treeDescription }
}

extension Operation {
    private func findNextOp(_ currentOp: MathNode, mainframe: Mainframe, checkParent: Bool = true, skip: MathNode? = nil) -> MathNode? {
        if currentOp.op.isNoOp && currentOp != skip {
            return currentOp
        }

        for child in currentOp.mathChildren {
            if child == skip { continue }
            if let nextOp = findNextOp(child, mainframe: mainframe, checkParent: false) {
                return nextOp
            }
        }

        if let parent = currentOp.parent as? MathNode, checkParent {
            return findNextOp(parent, mainframe: mainframe, skip: currentOp)
        }
        return nil
    }

    func tapped(_ mainframe: Mainframe, isFirst: Bool) {
        guard let currentOp = mainframe.currentOp else { return }

        switch self {
        case .nxttt:
            mainframe.currentOp = findNextOp(currentOp, mainframe: mainframe, skip: currentOp)
            mainframe.checkCameraLocation()
        case let .key(keyCode):
            switch keyCode {
            case .delete:
                var string = currentOp.numberString
                if !string.isEmpty {
                    string = String(string[string.startIndex..<string.index(before: string.endIndex)])
                }
                currentOp.numberString = string
                if string == "" {
                    currentOp.op = .noOp(isSelected: true)
                }
                else {
                    currentOp.op = .number(string)
                }
            case .clear:
                currentOp.numberString = ""
                currentOp.op = .noOp(isSelected: true)
            case .num1, .num2, .num3, .num4, .num5,
                 .num6, .num7, .num8, .num9, .num0,
                 .dot:
                if isFirst {
                    currentOp.numberString = keyCode.string
                    currentOp.op = .number(keyCode.string)
                }
                else {
                    currentOp.numberString += keyCode.string
                    currentOp.op = .number(currentOp.numberString)
                }
            case .sign:
                var string = currentOp.numberString
                if !string.isEmpty {
                    if string[string.startIndex] == "-" {
                        string = String(string[string.index(after: string.startIndex)..<string.endIndex])
                    }
                    else {
                        string = "-" + string
                    }
                    currentOp.numberString = string
                    currentOp.op = .number(string)
                }
            }
        default:
            currentOp.op = self
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
