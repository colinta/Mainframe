////
/// CosOperation.swift
//

struct CosOperation: OperationValue {
    var description: String { return "cos(◻)" }
    var treeDescription: String { return "cos" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "cos(\(node.formula(isTop: true)))"
        }
        return "cos(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }

        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        switch nodeVal {
        case .nan, .divZero, .needsInput: return nodeVal
        case let .number(number, numberPi):
            return .checkNumber(number: Decimal(cos((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}
