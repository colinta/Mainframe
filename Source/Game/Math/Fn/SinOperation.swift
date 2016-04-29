//
//  SinOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct SinOperation: OperationValue {
    var description: String { return "sin(◻︎)" }
    var treeDescription: String { return "sin" }
    var minChildNodes: Int? { return 1 }
    var maxChildNodes: Int? { return 1 }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        if let node = nodes.first where nodes.count == 1 {
            return "sin(\(node.formula(isTop: true)))"
        }
        return "sin(◻︎)"
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if let node = nodes.first where nodes.count == 1 {
            let nodeVal = node.calculate()
            switch nodeVal {
            case .DivZero, .NeedsInput: return nodeVal
            case let .Number(number: number, pi: pi):
                if number == 0 {
                    switch (2 * pi.doubleValue) % 4 {
                    case 0, 2:
                        return .Number(number: 0, pi: 0)
                    case 1:
                        return .Number(number: 1, pi: 0)
                    case 3:
                        return .Number(number: -1, pi: 0)
                    default: break
                    }
                }
                return .Number(number: NSDecimalNumber(double: sin((number + NSDecimalNumber.pi(pi)).doubleValue)), pi: 0)
            }
        }
        return .NeedsInput
    }
}
