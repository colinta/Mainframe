//
//  MultiplyOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct MultiplyOperation: OperationValue {
    var description: String { return "◻×◼" }
    var treeDescription: String { return "×" }
    var minChildNodes: Int? { return 2 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        guard isTop else { return "(\(formula(nodes, isTop: true)))" }

        if let node = nodes.first where nodes.count == 1 {
            return node.formula() + "×◼"
        }
        else if nodes.count > 1 {
            var result = ""
            var first = true
            for node in nodes {
                if !first {
                    result += "×"
                }
                result += node.formula()
                first = false
            }
            return result
        }
        return "◻×◼"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if nodes.count > 1 {
            var numbers: [(NSDecimalNumber, NSDecimalNumber)] = []

            for node in nodes {
                let nodeVal = node.calculate()
                switch nodeVal {
                case .NaN, .DivZero, .NeedsInput: return nodeVal
                case let .Number(number, pi):
                    if number == 0 && pi == 0 {
                        return .Number(number: 0, pi: 0)
                    }
                    numbers << (number, pi)
                }
            }

            var result: NSDecimalNumber
            var resultPi: NSDecimalNumber
            let piCounts = numbers.filter { (_, pi) in pi != 0 }.count
            let piAndNumberCounts = numbers.filter { (number, pi) in pi != 0 && number != 0 }.count
            if piCounts == 1 && piAndNumberCounts == 0 {
                result = 0
                resultPi = 1
                for (number, pi) in numbers {
                    if number == 0 {
                        resultPi = resultPi * pi
                    }
                    else {
                        resultPi = resultPi * number
                    }
                }
            }
            else {
                result = 1
                resultPi = 0
                for (number, pi) in numbers {
                    result = result * (number + NSDecimalNumber.pi(pi))
                }
            }
            return .Number(number: result, pi: resultPi)
        }
        return .NeedsInput
    }
}
