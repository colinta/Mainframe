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
        switch nodeVal {
        case .nan, .divZero, .needsInput: return nodeVal
        case let .number(number, numberPi):
            if numberPi == 0 {
                switch number {
                case -1:
                    return .number(number: 0, pi: 1)
                case 0:
                    return .number(number: 0, pi: 0.5)
                case 1:
                    return .number(number: 0, pi: 0)
                default: break
                }
            }
            return .checkNumber(number: Decimal(acos((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}
