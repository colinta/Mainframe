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

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }

        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        return nodeVal.mapDecimal { number in
            return number.mapDouble(log10)
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

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }
        let nodeVal = node.calculate(vars: vars, avoidRecursion: avoidRecursion)
        return nodeVal.mapDecimal { number in
            return number.mapDouble(log)
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

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        guard let base = nodes.safe(0), let number = nodes.safe(1) else { return .needsInput }

        let baseVal = base.calculate(vars: vars, avoidRecursion: avoidRecursion)
        let numberVal = number.calculate(vars: vars, avoidRecursion: avoidRecursion)
        return OperationResult.map2(baseVal, numberVal) { number, base in
            return number.mapDouble(log) / base.mapDouble(log)
        }
    }
}
