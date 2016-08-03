//
//  AssignOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/29/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
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

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "\(name)=\(node.formula(isTop: true))"
        }
        return "\(name)=◻"
    }

    func calculate(nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            return node.calculate(vars)
        }
        return .NeedsInput
    }
}
