//
//  AddOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct AddOperation: OperationValue {
    var description: String { return "◻+◼" }
    var treeDescription: String { return "+" }
    var minChildNodes: Int? { return 2 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        guard isTop else { return "(\(formula(nodes, isTop: true)))" }

        if let node = nodes.first where nodes.count == 1 {
            return node.formula() + "+◼"
        }
        else if nodes.count > 1 {
            var result = ""
            var first = true
            for node in nodes {
                if !first {
                    result += "+"
                }
                result += node.formula()
                first = false
            }
            return result
        }
        return "◻+◼"
    }

    func calculate(nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        if nodes.count > 1 {
            var result = NSDecimalNumber.zero()
            var resultPi = NSDecimalNumber.zero()
            for node in nodes {
                let nodeVal = node.calculate(vars)
                switch nodeVal {
                case .NaN, .DivZero, .NeedsInput: return nodeVal
                case let .Number(number, pi):
                    result = result + number
                    resultPi = resultPi + pi
                }
            }
            return .Number(number: result, pi: resultPi)
        }
        return .NeedsInput
    }
}
