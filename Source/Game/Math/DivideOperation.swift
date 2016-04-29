//
//  DivideOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct DivideOperation: OperationValue {
    var description: String { return "◻︎÷◼︎" }
    var treeDescription: String { return "÷" }
    var minChildNodes: Int? { return 2 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        guard isTop else { return "(\(formula(nodes, isTop: true)))" }

        if let node = nodes.first where nodes.count == 1 {
            return node.formula() + "÷◼︎"
        }
        else if nodes.count > 1 {
            var result = ""
            var first = true
            for node in nodes {
                if !first {
                    result += "÷"
                }
                result += node.formula()
                first = false
            }
            return result
        }
        return "◻︎÷◼︎"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if nodes.count > 1 {
            var result = NSDecimalNumber.one()
            var first = true
            for node in nodes {
                let nodeVal = node.calculate()
                switch nodeVal {
                case .DivZero, .NeedsInput: return nodeVal
                case let .Number(number, pi):
                    if first {
                        result = number + NSDecimalNumber.pi(pi)
                        first = false
                    }
                    else if number == 0 && pi == 0 {
                        return .DivZero
                    }
                    else {
                        result = result / (number + NSDecimalNumber.pi(pi))
                    }
                }
            }
            return .Number(number: result, pi: 0)
        }
        return .NeedsInput
    }
}
