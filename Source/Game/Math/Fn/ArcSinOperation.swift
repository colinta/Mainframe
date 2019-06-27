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
        switch nodeVal {
        case .nan, .divZero, .needsInput: return nodeVal
        case let .number(number, numberPi):
            if numberPi == 0 {
                switch number {
                case -1:
                    return .number(number: 0, pi: -0.5)
                case 0:
                    return .number(number: 0, pi: 0)
                case 1:
                    return .number(number: 0, pi: 0.5)
                default: break
                }
            }
            return .checkNumber(number: Decimal(asin((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}
