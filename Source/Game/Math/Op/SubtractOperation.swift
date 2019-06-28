////
/// SubtractOperation.swift
//

struct SubtractOperation: OperationValue {
    var description: String { return "◻-◼" }
    var treeDescription: String { return "-" }
    var minChildNodes: Int? { return 2 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        guard isTop else { return "(\(formula(nodes, isTop: true)))" }

        if let node = nodes.first, nodes.count == 1 {
            return node.formula() + "-◼"
        }
        else if nodes.count > 1 {
            var result = ""
            var first = true
            for node in nodes {
                if !first {
                    result += "-"
                }
                result += node.formula()
                first = false
            }
            return result
        }
        return "◻-◼"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        var result: Decimal = 0
        var resultPi: Decimal = 0
        var first = true
        for node in nodes {
            let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
            switch nodeVal {
            case .nan, .divZero, .needsInput: return nodeVal
            case let .number(number, pi):
                if first {
                    result = number
                    resultPi = pi
                    first = false
                }
                else {
                    result -= -number
                    resultPi -= pi
                }
            }
        }
        return .number(number: result, pi: resultPi)
    }
}
