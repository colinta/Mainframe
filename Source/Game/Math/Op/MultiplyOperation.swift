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
            for node in nodes {
                if node != nodes.first {
                    result += "×"
                }
                result += node.formula()
            }
            return result
        }
        return "◻×◼"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard nodes.count > 1 else { return .needsInput }

        // filter out non-numbers and pass them through, and quick return when
        // multiplying times zero
        var numbers: [ExactNumber] = []
        for node in nodes {
            let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
            switch nodeVal {
            case .nan, .divZero, .needsInput: return nodeVal
            case let .number(exact):
                if exact.isZero {
                    return .number(.zero)
                }
                numbers << exact
            }
        }

        let piCounts = numbers.filter { exact in exact.hasPi }.count
        let piAndNumberCounts = numbers.filter { exact in exact.hasPi && exact.hasWhole }.count
        if piCounts == 1 && piAndNumberCounts == 0 {
            // more accurate calculation for (a * b * c * pi); when one number
            // has a pi value, multiply the non-pi numbers and retain the pi number
            // e.g. 2 * pi aka (number 2, pi: 0) * (number: 0, pi: 1) becomes (number: 0, pi: 2)
            var resultPi: Decimal = 1
            var isFirst = true
            for exact in numbers {
                if isFirst {
                    resultPi *= exact.pi
                    isFirst = false
                }
                else {
                    resultPi *= exact.whole
                }
            }
            return .number(ExactNumber(pi: resultPi))
        }
        else {
            var result: Decimal = 1
            for exact in numbers {
                result *= exact.toDecimal
            }
            return .number(ExactNumber(whole: result))
        }
    }
}
