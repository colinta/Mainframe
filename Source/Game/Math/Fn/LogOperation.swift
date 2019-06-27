////
/// LogOperation.swift
//

struct LogOperation: OperationValue {
    var description: String { return "log(◻)" }
    var treeDescription: String { return "log" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "log(\(node.formula(isTop: true)))"
        }
        return "log(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }

        let nodeVal = node.calculate(vars)
        switch nodeVal {
        case .nan, .divZero, .needsInput: return nodeVal
        case let .number(number, numberPi):
            return .checkNumber(number: Decimal(log10((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}

struct LnOperation: OperationValue {
    var description: String { return "ln(◻)" }
    var treeDescription: String { return "ln" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        guard let node = nodes.first, nodes.count == 1 else { return "ln(◻)" }
        return "ln(\(node.formula(isTop: true)))"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }
        let nodeVal = node.calculate(vars)
        switch nodeVal {
        case .nan, .divZero, .needsInput: return nodeVal
        case let .number(number, numberPi):
            return .checkNumber(number: Decimal(log((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}

struct LogNOperation: OperationValue {
    var description: String { return "logₒ(◻)" }
    var treeDescription: String { return "logₒ" }
    var minChildNodes: Int? { return 2 }
    var maxChildNodes: Int? { return 2 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let base = nodes.first, nodes.count == 1 {
            return "log(◻) base \(base.formula(isTop: true))"
        }
        else if let base = nodes.safe(0), let number = nodes.safe(1) {
            return "log(\(number.formula(isTop: false)) base \(base.formula(isTop: true)))"
        }
        return "logₒ(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard let base = nodes.safe(0), let number = nodes.safe(1) else { return .needsInput }

        let baseVal = base.calculate(vars)
        let numberVal = number.calculate(vars)

        switch (numberVal, baseVal) {
        case (.nan, _), (.divZero, _), (.needsInput, _): return numberVal
        case (_, .nan), (_, .divZero), (_, .needsInput): return baseVal
        case let (.number(number: numberNumber, pi: numberPi), .number(baseNumber, basePi)):
            let numberActual = numberNumber + Decimal.pi(times: numberPi)
            let baseActual = baseNumber + Decimal.pi(times: basePi)
            return .checkNumber(number: Decimal(log(numberActual.asDouble) / log(baseActual.asDouble)), pi: 0)
        default:
            return .needsInput
        }
}
}
