//
//  ArcTanOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/29/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct ArcTanOperation: OperationValue {
    var description: String { return "arctan()" }
    var treeDescription: String { return "arctan" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "arctan(\(node.formula(isTop: true)))"
        }
        return "arctan(◻)"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            let nodeVal = node.calculate()
            switch nodeVal {
            case .NaN, .DivZero, .NeedsInput: return nodeVal
            case let .Number(number, pi):
                return .CheckNumber(number: NSDecimalNumber(double: atan((number + NSDecimalNumber.pi(pi)).doubleValue)), pi: 0)
            }
        }
        return .NeedsInput
    }
}
