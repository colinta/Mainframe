////
/// FactorialOperation.swift
//

struct FactorialOperation: OperationValue {
    var description: String { return "◻!" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "\(node.formula())!"
        }
        return "◻!"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }

        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        switch nodeVal {
        case .nan, .divZero, .needsInput: return nodeVal
        case let .number(number, numberPi):
            let asDouble = (number + Decimal.pi(times: numberPi)).asDouble
            return .checkNumber(number: Decimal(tgamma(1 + asDouble)), pi: 0)
        }
    }
}
