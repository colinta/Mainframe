////
/// TanOperation.swift
//

struct TanOperation: OperationValue {
    var description: String { return "tan(◻)" }
    var treeDescription: String { return "tan" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "tan(\(node.formula(isTop: true)))"
        }
        return "tan(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }

        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        switch nodeVal {
        case .nan, .divZero, .needsInput: return nodeVal
        case let .number(number, numberPi):
            return .checkNumber(number: Decimal(tan((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}
