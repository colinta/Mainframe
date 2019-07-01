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
            for node in nodes {
                if node != nodes.first {
                    result += "÷"
                }
                result += node.formula()
            }
            return result
        }
        return "◻÷◼"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard nodes.count > 1 else { return .needsInput }

        // filter out non-numbers and pass them through, and quick return when
        // dividing by zero
        var numerator: ExactNumber = .zero
        var denominators: [ExactNumber] = []
        var isFirst = true
        for node in nodes {
            let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
            switch nodeVal {
            case .nan, .divZero, .needsInput: return nodeVal
            case let .number(exact):
                if exact.isZero && !isFirst {
                    return .divZero
                }

                if isFirst {
                    numerator = exact
                }
                else {
                    denominators << exact
                }
            }
            isFirst = false
        }

        // quick return if dividing 0 by anything non-zero
        if numerator.isZero {
            return .number(.zero)
        }

        let firstIsPi = !numerator.hasWhole && numerator.hasPi
        let denominatorHasPi = denominators.any({ $0.hasPi })
        if firstIsPi && !denominatorHasPi {
            // first number has pi in it, and no number
            // none of the denominators have pi
            // set the result to the first pi number, and divide the rest
            // so 2 * pi / 4 aka (number: 0, pi: 2) / (number: 4, pi: 0) becomes
            // (number: 0, pi: 0.5)
            var resultPi: Decimal = numerator.pi
            for exact in denominators {
                resultPi /= exact.whole
            }
            return .number(ExactNumber(pi: resultPi))
        }
        else {
            var result: Decimal = numerator.toDecimal
            for exact in denominators {
                result /= exact.toDecimal
            }
            return .number(ExactNumber(whole: result))
        }
    }
}
