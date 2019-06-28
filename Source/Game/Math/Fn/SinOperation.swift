////
/// SinOperation.swift
//

struct SinOperation: OperationValue {
    var description: String { return "sin(◻)" }
    var treeDescription: String { return "sin" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "sin(\(node.formula(isTop: true)))"
        }
        return "sin(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }

        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        return nodeVal.mapDecimal { number in
            return number.mapDouble(sin)
        }
    }
}
