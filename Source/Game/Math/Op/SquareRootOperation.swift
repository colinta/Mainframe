//
//  SquareRootOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct SquareRootOperation: OperationValue {
    var description: String { return "√◻" }
    var treeDescription: String { return "√" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "√(\(node.formula(isTop: true)))"
        }
        return "√(◻)"
    }

    func calculate(nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            let nodeVal = node.calculate(vars)
            switch nodeVal {
            case .NaN, .DivZero, .NeedsInput: return nodeVal
            case let .Number(number, pi):
                return .CheckNumber(number: NSDecimalNumber(double: sqrt((number + NSDecimalNumber.pi(pi)).doubleValue)), pi: 0)
            }
        }
        return .NeedsInput
    }

}
