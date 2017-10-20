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

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard nodes.count > 1 else { return .NeedsInput }

        var numbers: [(Decimal, Decimal)] = []
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

        var result: Decimal
        var resultPi: Decimal
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
            for (number, numberPi) in numbers {
                result = result * (number + Decimal.pi(times: numberPi))
            }
        }
        return .Number(number: result, pi: resultPi)
    }
}
