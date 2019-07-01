////
/// ArcSinOperation.swift
//

struct ArcSinOperation: OperationValue {
    var description: String { return "arcsin()" }
    var treeDescription: String { return "arcsin" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "arcsin(\(node.formula(isTop: true)))"
        }
        return "arcsin(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }
        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        return nodeVal.map { exact in
            if exact.pi == 0 {
                switch exact.toDecimal {
                case -1:
                    return ExactNumber(pi: -0.5)
                case 0:
                    return ExactNumber(pi: 0)
                case 1:
                    return ExactNumber(pi: 0.5)
                default: break
                }
            }
            return ExactNumber(whole: exact.toDecimal.mapDouble(asin))
        }
    }
}
