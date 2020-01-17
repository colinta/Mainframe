////
/// SquaredOperation.swift
//

struct SquaredOperation: OperationValue {
    var description: String { return "◻²" }
    var treeDescription: String { return "◻²" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first {
            return "(\(node.formula(isTop: true)))²"
        }
        return "◻²"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }

        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        return nodeVal.mapDecimal { number in
            return number.mapDouble { pow($0, 2) }
        }
    }

}
