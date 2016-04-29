//
//  OperationValue.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

protocol OperationValue {
    func formula(nodes: [MathNode], isTop: Bool) -> String
    func calculate(nodes: [MathNode]) -> OperationResult
    var minChildNodes: Int? { get }
    var maxChildNodes: Int? { get }
    var description: String { get }
    var treeDescription: String { get }
}

extension OperationValue {
    func formula(nodes: [MathNode], isTop: Bool) -> String { return "..." }
    func calculate(nodes: [MathNode]) -> OperationResult { return .NeedsInput }
    var minChildNodes: Int? { return nil }
    var maxChildNodes: Int? { return nil }
    var treeDescription: String { return description }
}
