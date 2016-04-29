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
    case Pi
    case Tau
    case E

    case Factorial
    case SquareRoot

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

    func panel(mainframe: Mainframe) -> Mainframe.PanelItem? {
        switch self {
        case Operator:
            return mainframe.operatorsItem
        case Variable, Pi, E, Tau:
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
        case Pi:                return VariableOperation("π")
        case Tau:               return VariableOperation("τ")
        case E:                 return VariableOperation("𝑒")
        case Factorial:         return FactorialOperation()
        case SquareRoot:        return SquareRootOperation()
        case let Operator(op):  return op
        case let Function(fn):  return fn
        default:                return NoOperation()
        }
    }
}

extension Operation: OperationValue {
    func formula(nodes: [MathNode], isTop: Bool) -> String { return opValue.formula(nodes, isTop: isTop) }
    func calculate(nodes: [MathNode]) -> OperationResult { return opValue.calculate(nodes) }
    var minChildNodes: Int? { return opValue.minChildNodes }
    var maxChildNodes: Int? { return opValue.maxChildNodes }
    var description: String { return opValue.description }
    var treeDescription: String { return opValue.treeDescription }
}

extension Operation {
    private func findNextOp(currentOp: MathNode, world: Mainframe, checkParent: Bool = true, skip: MathNode? = nil) -> MathNode? {
        if currentOp.op.isNoOp && currentOp != skip {
            return currentOp
        }

        for child in currentOp.mathChildren {
            if child == skip { continue }
            if let nextOp = findNextOp(child, world: world, checkParent: false) {
                return nextOp
            }
        }

        if let parent = currentOp.parent as? MathNode where checkParent {
            return findNextOp(parent, world: world, skip: currentOp)
        }
        return nil
    }

    func tapped(world: Mainframe) {
        guard let currentOp = world.currentOp else { return }

        switch self {
        case Next:
            world.currentOp = findNextOp(currentOp, world: world, skip: currentOp)
            world.checkCameraLocation()
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
            case .Num1:
                currentOp.numberString += "1"
                currentOp.op = .Number(currentOp.numberString)
            case .Num2:
                currentOp.numberString += "2"
                currentOp.op = .Number(currentOp.numberString)
            case .Num3:
                currentOp.numberString += "3"
                currentOp.op = .Number(currentOp.numberString)
            case .Num4:
                currentOp.numberString += "4"
                currentOp.op = .Number(currentOp.numberString)
            case .Num5:
                currentOp.numberString += "5"
                currentOp.op = .Number(currentOp.numberString)
            case .Num6:
                currentOp.numberString += "6"
                currentOp.op = .Number(currentOp.numberString)
            case .Num7:
                currentOp.numberString += "7"
                currentOp.op = .Number(currentOp.numberString)
            case .Num8:
                currentOp.numberString += "8"
                currentOp.op = .Number(currentOp.numberString)
            case .Num9:
                currentOp.numberString += "9"
                currentOp.op = .Number(currentOp.numberString)
            case .Num0:
                currentOp.numberString += "0"
                currentOp.op = .Number(currentOp.numberString)
            case .NumDot:
                currentOp.numberString += "."
                currentOp.op = .Number(currentOp.numberString)
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

extension Operation: Buttonable {
    func asButton() -> Button {
        return description.asButton()
    }
}
