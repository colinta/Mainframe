////
/// OperationValue.swift
//

protocol OperationValue {
    func formula(_ nodes: [MathNode], isTop: Bool) -> String
    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult

    var mustBeTop: Bool { get }
    var minChildNodes: Int? { get }
    var maxChildNodes: Int? { get }
    var description: String { get }
    func description(editing: MathNode.Editing) -> String
    var treeDescription: String { get }
}

extension OperationValue {
    var mustBeTop: Bool { false }
    var minChildNodes: Int? { nil }
    var maxChildNodes: Int? { nil }
    var treeDescription: String { description }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        "..."
    }
    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        .needsInput
    }
    func description(editing: MathNode.Editing) -> String {
        description
    }
}
