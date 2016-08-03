//
//  TanOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct TanOperation: OperationValue {
    var description: String { return "tan(◻)" }
    var treeDescription: String { return "tan" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "tan(\(node.formula(isTop: true)))"
        }
        return "tan(◻)"
    }

    func calculate(nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            let nodeVal = node.calculate(vars)
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
                return .CheckNumber(number: NSDecimalNumber(double: tan((number + NSDecimalNumber.pi(pi)).doubleValue)), pi: 0)
            }
        }
        return .NeedsInput
    }
}
