////
/// ExponentOperation.swift
//

struct ExponentOperation: OperationValue {
    var description: String { return "◻▝" }
    var treeDescription: String { return "◻▝" }
    var minChildNodes: Int? { return 2 }
    var maxChildNodes: Int? { return 2 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node1 = nodes.safe(0), let node2 = nodes.safe(1) {
            return "(\(node1.formula(isTop: true)))^(\(node2.formula(isTop: true)))"
        }
        if let node1 = nodes.safe(0), nodes.count == 1 {
            return "(\(node1.formula(isTop: true)))▝"
        }
        return "◻▝"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard
            let node1 = nodes.safe(0),
            let node2 = nodes.safe(1)
        else { return .needsInput }

        let node1Val = node1.calculate(vars: vars, avoidRecursion: avoidRecursion)
        let node2Val = node2.calculate(vars: vars, avoidRecursion: avoidRecursion)
        switch (node1Val, node2Val) {
        case (.needsInput, _), (_, .needsInput): return .needsInput
        case (.divZero, _), (_, .divZero): return .divZero
        case let (.number(number1, number1Pi), .number(number2, number2Pi)):
            let base = number1 + Decimal.pi(times: number1Pi)
            let power = number2 + Decimal.pi(times: number2Pi)
            return .checkNumber(number: Decimal(pow(base.asDouble, power.asDouble)), pi: 0)
        default:
            return .nan
        }
    }

}
