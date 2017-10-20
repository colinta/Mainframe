//
//  OperationValue.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

protocol OperationValue {
    func formula(_ nodes: [MathNode], isTop: Bool) -> String
    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult
    func newNode() -> MathNode

    var mustBeTop: Bool { get }
    var minChildNodes: Int? { get }
    var maxChildNodes: Int? { get }
    var description: String { get }
    var treeDescription: String { get }
}

extension OperationValue {
    func formula(_ nodes: [MathNode], isTop: Bool) -> String { return "..." }
    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult { return .NeedsInput }
    func newNode() -> MathNode { return MathNode() }
    var mustBeTop: Bool { return false }
    var minChildNodes: Int? { return nil }
    var maxChildNodes: Int? { return nil }
    var treeDescription: String { return description }
}
