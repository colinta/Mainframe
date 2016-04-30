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
    let number: NSDecimalNumber?

    init(_ numberString: String) {
        let dec = NSDecimalNumber(string: numberString)
        if dec != NSDecimalNumber.notANumber() {
            if numberString.contains(".") {
                var found = false
                let parts = numberString.characters.split {
                    if $0 == "." && !found { found = true ; return true }
                    return false
                    }.map { String($0) }
                let (lhs, rhs) = (parts.safe(0) ?? "", parts.safe(1) ?? "")
                self.description = lhs.withCommas() + "." + rhs
            }
            else {
                self.description = numberString.withCommas()
            }

            self.number = dec
        }
        else {
            self.description = numberString
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
