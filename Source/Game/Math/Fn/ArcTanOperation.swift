//
//  ArcTanOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/29/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct ArcTanOperation: OperationValue {
    var description: String { return "arctan()" }
    var treeDescription: String { return "arctan" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first, nodes.count == 1 {
            return "arctan(\(node.formula(isTop: true)))"
        }
        return "arctan(◻)"
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        guard let node = nodes.first, nodes.count == 1 else { return .NeedsInput }

        let nodeVal = node.calculate(vars)
        switch nodeVal {
        case .NaN, .DivZero, .NeedsInput: return nodeVal
        case let .Number(number, numberPi):
            return .CheckNumber(number: Decimal(atan((number + Decimal.pi(times: numberPi)).asDouble)), pi: 0)
        }
    }
}
