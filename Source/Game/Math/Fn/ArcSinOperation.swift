//
//  ArcSinOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/29/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct ArcSinOperation: OperationValue {
    var description: String { return "arcsin()" }
    var treeDescription: String { return "arcsin" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "arcsin(\(node.formula(isTop: true)))"
        }
        return "arcsin(◻)"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            let nodeVal = node.calculate()
            switch nodeVal {
            case .NaN, .DivZero, .NeedsInput: return nodeVal
            case let .Number(number, pi):
                if pi == 0 {
                    switch number {
                    case -1:
                        return .Number(number: 0, pi: -0.5)
                    case 0:
                        return .Number(number: 0, pi: 0)
                    case 1:
                        return .Number(number: 0, pi: 0.5)
                    default: break
                    }
                }
                return .CheckNumber(number: NSDecimalNumber(double: asin((number + NSDecimalNumber.pi(pi)).doubleValue)), pi: 0)
            }
        }
        return .NeedsInput
    }
}
