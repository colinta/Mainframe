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
    var description: String
    let number: NSDecimalNumber?

    init(_ numberString: String) {
        self.description = numberString
        let dec = NSDecimalNumber(string: numberString)
        if dec != NSDecimalNumber.notANumber() {
            self.number = dec
        }
        else {
            self.number = nil
        }
    }

    func formula(nodes: [MathNode], isTop: Bool) -> String {
        return description
    }

    func calculate(nodes: [MathNode]) -> OperationResult {
        if let number = number {
            return .Number(number: number, pi: 0)
        }
        return .NeedsInput
    }
}
