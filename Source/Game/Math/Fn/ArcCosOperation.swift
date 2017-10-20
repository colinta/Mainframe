//
//  ArcCosOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/29/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct ArcCosOperation: OperationValue {
    var description: String { return "arccos()" }
    var treeDescription: String { return "arccos" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "arccos(\(node.formula(isTop: true)))"
        }
        return "arccos(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else {
            return .NeedsInput
        }

        let nodeVal = node.calculate(vars)
        switch nodeVal {
        case .NaN, .DivZero, .NeedsInput: return nodeVal
        case let .Number(number, numberPi):
            if numberPi == 0 {
                switch number {
                case -1:
                    return .Number(number: 0, pi: 1)
                case 0:
                    return .Number(number: 0, pi: 0.5)
                case 1:
                    return .Number(number: 0, pi: 0)
                default: break
                }
            }
            return .CheckNumber(number: Decimal(acos((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}
