//
//  LogOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/29/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct LogOperation: OperationValue {
    var description: String { return "log(◻)" }
    var treeDescription: String { return "log" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "log(\(node.formula(isTop: true)))"
        }
        return "log(◻)"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            let nodeVal = node.calculate()
            switch nodeVal {
            case .NaN, .DivZero, .NeedsInput: return nodeVal
            case let .Number(number, pi):
                if number == 0 {
                    switch (2 * pi.doubleValue) % 4 {
                    case 1, 3:
                        return .DivZero
                    case 0, 2:
                        return .Number(number: 0, pi: 0)
                    default: break
                    }
                }
                return .CheckNumber(number: NSDecimalNumber(double: log10((number + NSDecimalNumber.pi(pi)).doubleValue)), pi: 0)
            }
        }
        return .NeedsInput
    }
}

struct LnOperation: OperationValue {
    var description: String { return "ln(◻)" }
    var treeDescription: String { return "ln" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "ln(\(node.formula(isTop: true)))"
        }
        return "ln(◻)"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            let nodeVal = node.calculate()
            switch nodeVal {
            case .NaN, .DivZero, .NeedsInput: return nodeVal
            case let .Number(number, pi):
                if number == 0 {
                    switch (2 * pi.doubleValue) % 4 {
                    case 1, 3:
                        return .DivZero
                    case 0, 2:
                        return .Number(number: 0, pi: 0)
                    default: break
                    }
                }
                return .CheckNumber(number: NSDecimalNumber(double: log((number + NSDecimalNumber.pi(pi)).doubleValue)), pi: 0)
            }
        }
        return .NeedsInput
    }
}

struct LogNOperation: OperationValue {
    var description: String { return "logₒ(◻)" }
    var treeDescription: String { return "logₒ" }
    var minChildNodes: Int? { return 2 }
    var maxChildNodes: Int? { return 2 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let number = nodes.first where nodes.count == 1 {
            return "logₒ(\(number.formula(isTop: true)))"
        }
        else if let number = nodes.first, base = nodes.last where nodes.count == 2 {
            return "log(\(number.formula(isTop: true)) b \(base.formula(isTop: true)))"
        }
        return "logₒ(◻)"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if let number = nodes.first, base = nodes.last where nodes.count == 2 {
            let baseVal = base.calculate()
            let numberVal = number.calculate()
            switch (numberVal, baseVal) {
            case (.NaN, _), (.DivZero, _), (.NeedsInput, _): return numberVal
            case (_, .NaN), (_, .DivZero), (_, .NeedsInput): return baseVal
            case let (.Number(number: numberNumber, pi: numberPi), .Number(baseNumber, basePi)):
                let numberActual = numberNumber + NSDecimalNumber.pi(numberPi)
                let baseActual = baseNumber + NSDecimalNumber.pi(basePi)
                return .CheckNumber(number: NSDecimalNumber(double: log(numberActual.doubleValue) / log(baseActual.doubleValue)), pi: 0)
            default: break
            }
        }
        return .NeedsInput
    }
}
