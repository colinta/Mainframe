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
            for node in nodes {
                if node != nodes.first {
                    result += "-"
                }
                result += node.formula()
            }
            return result
        }
        return "◻-◼"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        var isFirst = false
        return OperationResult.reduce(nodes.lazy.map { $0.calculate(vars: vars, avoidRecursion: avoidRecursion) }) { result, exact in
            if isFirst {
                isFirst = false
                return exact
            }
            return result - exact
        }
    }
}
