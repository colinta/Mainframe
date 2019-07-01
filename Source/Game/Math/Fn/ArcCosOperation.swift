////
/// ArcCosOperation.swift
//

struct ArcCosOperation: OperationValue {
    var description: String { return "arccos()" }
    var treeDescription: String { return "arccos" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "arccos(\(node.formula(isTop: true)))"
        }
        return "arccos(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else {
            return .needsInput
        }

        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        return nodeVal.map { exact in
            if exact.pi == 0 {
                switch exact.toDecimal {
                case -1:
                    return ExactNumber(pi: 1)
                case 0:
                    return ExactNumber(pi: 0.5)
                case 1:
                    return ExactNumber(pi: 0)
                default: break
                }
            }
            return ExactNumber(whole: exact.toDecimal.mapDouble(acos))
        }
    }
}
