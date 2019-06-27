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
    var treeDescription: String { get }
}

extension OperationValue {
    func formula(_ nodes: [MathNode], isTop: Bool) -> String { return "..." }
    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult { return .needsInput }
    var mustBeTop: Bool { return false }
    var minChildNodes: Int? { return nil }
    var maxChildNodes: Int? { return nil }
    var treeDescription: String { return description }
}
