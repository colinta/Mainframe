////
/// DivideOperation.swift
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

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard nodes.count > 1 else { return .needsInput }

        // filter out non-numbers and pass them through, and quick return when
        // dividing by zero
        var numerator: (Decimal, pi: Decimal) = (0, 0)
        var denominators: [(Decimal, pi: Decimal)] = []
        var isFirst = true
        for node in nodes {
            let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
            switch nodeVal {
            case .nan, .divZero, .needsInput: return nodeVal
            case let .number(number, pi):
                if number == 0 && pi == 0 && !isFirst {
                    return .divZero
                }

                if isFirst {
                    numerator = (number, pi)
                }
                else {
                    denominators << (number, pi)
                }
            }
            isFirst = false
        }

        // quick return if dividing 0 by anything non-zero
        if numerator.0 == 0 && numerator.pi == 0 {
            return .number(number: 0, pi: 0)
        }

        let firstIsPi = numerator.0 == 0 && numerator.pi != 0
        let piCounts = denominators.filter { (_, pi) in pi != 0 }.count
        if firstIsPi && piCounts == 0 {
            // first number has pi in it, and no number
            // none of the denominators have pi
            // set the result to the first pi number, and divide the rest
            // so 2 * pi / 4 aka (number: 0, pi: 2) / (number: 4, pi: 0) becomes
            // (number: 0, pi: 0.5)
            var resultPi: Decimal = numerator.pi
            for (number, _) in denominators {
                resultPi /= number
            }
            return .number(number: 0, pi: resultPi)
        }
        else {
            var result: Decimal = numerator.0 + numerator.pi.timesPi
            for (number, numberPi) in denominators {
                result /= number + numberPi.timesPi
            }
            return .number(number: result, pi: 0)
        }
    }
}
