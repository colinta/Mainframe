////
/// Operation.swift
//

enum WoodworkingUnit {
    case inches
    case feet
    case centimeters
    case millimeters
}

enum Operation {
    case nextBlankOp
    case key(KeyCode)

    case number(String)
    case woodworking(WoodworkingUnit, number: String, numerator: String, denominator: String)
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
        case .nextBlankOp:              return NextOperation()
        case let .number(num):   return NumberOperation(num)
        case let .woodworking(unit, number, numerator, denominator):
            return NumberOperation(number)
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

    func tapped(_ mainframe: Mainframe, isResetting: Bool) {
        guard let currentOp = mainframe.currentOp else { return }

        switch self {
        case .nextBlankOp:
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
            case .dot:
                if isResetting {
                    currentOp.numberString = "0."
                    currentOp.op = .number("0.")
                }
                else {
                    var string = currentOp.numberString
                    if !string.contains(".") {
                        string += keyCode.string
                        if string == "-." {
                            string = "-0."
                        }
                    }
                    currentOp.numberString = string
                    currentOp.op = .number(string)
                }
            case .num1, .num2, .num3, .num4, .num5,
                 .num6, .num7, .num8, .num9, .num0:
                if isResetting {
                    currentOp.numberString = keyCode.string
                    currentOp.op = .number(keyCode.string)
                }
                else {
                    var string = currentOp.numberString
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
                    currentOp.numberString = string
                    currentOp.op = .number(string)
                }
            case .sign:
                if case .variable("π") = currentOp.op {
                    currentOp.op = .variable("-π")
                }
                else if case .variable("-π") = currentOp.op {
                    currentOp.op = .variable("π")
                }
                else if case .variable("τ") = currentOp.op {
                    currentOp.op = .variable("-τ")
                }
                else if case .variable("-τ") = currentOp.op {
                    currentOp.op = .variable("τ")
                }

                var string = currentOp.numberString
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
