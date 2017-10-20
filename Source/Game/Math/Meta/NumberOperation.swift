//
//  NumberOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/24/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct NumberOperation: OperationValue {
    var minChildNodes: Int? { return 0 }
    var maxChildNodes: Int? { return 0 }
    let description: String
    let number: Decimal?

    init(_ numberString: String) {
        if let dec = Decimal(string: numberString) {
            self.description = numberString.withCommas()

            self.number = dec
        }
        else {
            self.description = numberString
            self.number = nil
        }
    }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        return description
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        if let number = number {
            return .Number(number: number, pi: 0)
        }
        return .NeedsInput
    }
}
