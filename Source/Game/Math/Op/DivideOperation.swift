//
//  DivideOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct DivideOperation: OperationValue {
    var description: String { return "◻÷◼" }
    var treeDescription: String { return "÷" }
    var minChildNodes: Int? { return 2 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        guard isTop else { return "(\(formula(nodes, isTop: true)))" }

        if let node = nodes.first, nodes.count == 1 {
            return node.formula() + "÷◼"
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
        return "◻÷◼"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard nodes.count > 1 else { return .NeedsInput }

        var numbers: [(Decimal, pi: Decimal)] = []
        for node in nodes {
            let nodeVal = node.calculate(vars)
            switch nodeVal {
            case .NaN, .DivZero, .NeedsInput: return nodeVal
            case let .Number(number, pi):
                if number == 0 && pi == 0 {
                    return .Number(number: 0, pi: 0)
                }
                numbers << (number, pi)
            }
        }

        // no denominator is zero,
        // we have at least two numbers

        var result: Decimal
        var resultPi: Decimal
        var first = true

        let firstIsPi = numbers[0].pi != 0
        let piCounts = numbers.filter { (_, pi) in pi != 0 }.count
        let piAndNumberCounts = numbers.filter { (number, pi) in pi != 0 && number != 0 }.count
        if firstIsPi && piCounts == 1 && piAndNumberCounts == 0 {
            // first one is pi, none of the others
            // none have pi and number
            // so every number except the first have a number
            result = 0
            resultPi = 1
            for (number, pi) in numbers {
                if first {
                    resultPi = pi
                }
                else {
                    resultPi = resultPi / number
                }
                first = false
            }
        }
        else {
            result = 1
            resultPi = 0
            for (number, numberPi) in numbers {
                if first {
                    result = number + Decimal.pi(times: numberPi)
                }
                else {
                    result = result / (number + Decimal.pi(times: numberPi))
                }
                first = false
            }
        }
        return .Number(number: result, pi: resultPi)
    }
}
