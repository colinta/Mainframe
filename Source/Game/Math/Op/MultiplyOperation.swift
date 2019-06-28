////
/// MultiplyOperation.swift
//

struct MultiplyOperation: OperationValue {
    var description: String { return "◻×◼" }
    var treeDescription: String { return "×" }
    var minChildNodes: Int? { return 2 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        guard isTop else { return "(\(formula(nodes, isTop: true)))" }

        if let node = nodes.first, nodes.count == 1 {
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

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard nodes.count > 1 else { return .needsInput }

        // filter out non-numbers and pass them through, and quick return when
        // multiplying times zero
        var numbers: [(Decimal, Decimal)] = []
        for node in nodes {
            let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
            switch nodeVal {
            case .nan, .divZero, .needsInput: return nodeVal
            case let .number(number, pi):
                if number == 0 && pi == 0 {
                    return .number(number: 0, pi: 0)
                }
                numbers << (number, pi)
            }
        }

        let piCounts = numbers.filter { (_, pi) in pi != 0 }.count
        let piAndNumberCounts = numbers.filter { (number, pi) in pi != 0 && number != 0 }.count
        if piCounts == 1 && piAndNumberCounts == 0 {
            // more accurate calculation for (a * b * c * pi); when one number
            // has a pi value, multiply the non-pi numbers and retain the pi number
            // e.g. 2 * pi aka (number 2, pi: 0) * (number: 0, pi: 1) becomes (number: 0, pi: 2)
            var resultPi: Decimal = 1
            for (number, pi) in numbers {
                if number == 0 {
                    resultPi *= pi
                }
                else {
                    resultPi *= number
                }
            }
            return .number(number: 0, pi: resultPi)
        }
        else {
            var result: Decimal = 1
            for (number, numberPi) in numbers {
                result *= number + numberPi.timesPi
            }
            return .number(number: result, pi: 0)
        }
    }
}
