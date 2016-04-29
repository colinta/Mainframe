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

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "arccos(\(node.formula(isTop: true)))"
        }
        return "arccos(◻︎)"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            let nodeVal = node.calculate()
            switch nodeVal {
            case .DivZero, .NeedsInput: return nodeVal
            case let .Number(number: number, pi: pi):
                if pi == 0 {
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
                return .Number(number: NSDecimalNumber(double: acos((number + NSDecimalNumber.pi(pi)).doubleValue)), pi: 0)
            }
        }
        return .NeedsInput
    }
}
