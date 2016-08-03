//
//  Operation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

enum Operation {
    case Next
    case Key(KeyCode)

    case Number(String)
    case Variable(String)
    case Assign(String)

    case Operator(OperationValue)
    case Function(OperationValue)

    case NoOp
    case NoOpSelected

    var isNoOp: Bool {
        switch self {
        case .NoOp, .NoOpSelected: return true
        default: return false
        }
    }

    func isVariable(name: String) -> Bool {
        switch self {
        case let Assign(varName):
            return name == varName
        default:
            return false
        }
    }

    func compatible(mainframe: Mainframe) -> Bool {
        switch self {
        case Assign:
            return mainframe.currentOp == mainframe.topNode
        case let Variable(name):
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
        case Operator:
            return mainframe.operatorsItem
        case Variable, Assign:
            return mainframe.variablesItem
        case Number:
            return mainframe.numbersItem
        case Function:
            return mainframe.functionsItem
        default:
            return nil
        }
    }
}

extension Operation {
    var opValue: OperationValue {
        switch self {
        case let Key(key):      return KeyOperation(op: key)
        case Next:              return NextOperation()
        case let Number(num):   return NumberOperation(num)
        case let Variable(num): return VariableOperation(num)
        case let Assign(num):   return AssignOperation(num)
        case let Operator(op):  return op
        case let Function(fn):  return fn
        default:                return NoOperation()
        }
    }
}

extension Operation: OperationValue {
    func formula(nodes: [MathNode], isTop: Bool) -> String { return opValue.formula(nodes, isTop: isTop) }
    func calculate(nodes: [MathNode], vars: VariableLookup) -> OperationResult { return opValue.calculate(nodes, vars: vars) }
    func newNode() -> MathNode { return opValue.newNode() }
    var mustBeTop: Bool { return opValue.mustBeTop }
    var minChildNodes: Int? { return opValue.minChildNodes }
    var maxChildNodes: Int? { return opValue.maxChildNodes }
    var description: String { return opValue.description }
    var treeDescription: String { return opValue.treeDescription }
}

extension Operation {
    private func findNextOp(currentOp: MathNode, mainframe: Mainframe, checkParent: Bool = true, skip: MathNode? = nil) -> MathNode? {
        if currentOp.op.isNoOp && currentOp != skip {
            return currentOp
        }

        for child in currentOp.mathChildren {
            if child == skip { continue }
            if let nextOp = findNextOp(child, mainframe: mainframe, checkParent: false) {
                return nextOp
            }
        }

        if let parent = currentOp.parent as? MathNode where checkParent {
            return findNextOp(parent, mainframe: mainframe, skip: currentOp)
        }
        return nil
    }

    func tapped(mainframe: Mainframe, first: Bool) {
        guard let currentOp = mainframe.currentOp else { return }

        switch self {
        case Next:
            mainframe.currentOp = findNextOp(currentOp, mainframe: mainframe, skip: currentOp)
            mainframe.checkCameraLocation()
        case let Key(keyCode):
            switch keyCode {
            case .Delete:
                var string = currentOp.numberString
                if string.characters.count > 0 {
                    string = string[string.startIndex..<string.endIndex.predecessor()]
                }
                currentOp.numberString = string
                if string == "" {
                    currentOp.op = .NoOpSelected
                }
                else {
                    currentOp.op = .Number(string)
                }
            case .Clear:
                currentOp.numberString = ""
                currentOp.op = .NoOpSelected
            case .Num1, .Num2, .Num3, .Num4, .Num5,
                 .Num6, .Num7, .Num8, .Num9, .Num0,
                 .NumDot:
                if first {
                    currentOp.numberString = keyCode.string
                    currentOp.op = .Number(keyCode.string)
                }
                else {
                    currentOp.numberString += keyCode.string
                    currentOp.op = .Number(currentOp.numberString)
                }
            case .SignSwitch:
                var string = currentOp.numberString
                if string.characters.count > 0 {
                    if string[string.startIndex] == "-" {
                        string = string[string.startIndex.successor()..<string.endIndex]
                    }
                    else {
                        string = "-" + string
                    }
                    currentOp.numberString = string
                    currentOp.op = .Number(string)
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
