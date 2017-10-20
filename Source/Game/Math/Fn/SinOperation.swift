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

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .NeedsInput }

        let nodeVal = node.calculate(vars)
        switch nodeVal {
        case .NaN, .DivZero, .NeedsInput: return nodeVal
        case let .Number(number, numberPi):
            return .CheckNumber(number: Decimal(sin((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}
