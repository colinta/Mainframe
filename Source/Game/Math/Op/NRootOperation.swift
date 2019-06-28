////
/// SquareRootOperation.swift
//

struct NRootOperation: OperationValue {
    var description: String { return "ⁿ√◻" }
    var treeDescription: String { return "ⁿ√" }
    var minChildNodes: Int? { return 2 }
    var maxChildNodes: Int? { return 2 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        let inside: String
        if let node1 = nodes.safe(0), let node2 = nodes.safe(1) {
            inside = "\(node1.formula(isTop: true))√\(node2.formula(isTop: true))"
        }
        else if let node1 = nodes.safe(0), nodes.count == 1 {
            inside = "\(node1.formula(isTop: true))√◻"
        }
        else {
            inside = "ⁿ√◻"
        }

        if isTop {
            return inside
        }
        return "(\(inside))"
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
            let root = number1 + number1Pi.timesPi
            let number = number2 + number2Pi.timesPi
            return .checkNumber(number: Decimal(pow(number.asDouble, 1/root.asDouble)), pi: 0)
        default:
            return .nan
        }
    }

}
