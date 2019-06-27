////
/// AssignOperation.swift
//

struct AssignOperation: OperationValue {
    var mustBeTop: Bool { return true }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }
    var description: String { return "\(name)=" }
    let name: String

    init(_ name: String) {
        self.name = name
    }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "\(name)=\(node.formula(isTop: true))"
        }
        return "\(name)=◻"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .needsInput }

        return node.calculate(vars)
    }
}
