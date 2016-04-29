//
//  OperationResult.swift
//  Mainframe
//
//  Created by Colin Gray on 4/24/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

enum OperationResult {
    case DivZero
    case NeedsInput
    case Number(number: NSDecimalNumber, pi: NSDecimalNumber)

    var number: String {
        switch self {
        case .DivZero: return description
        case .NeedsInput: return description
        case let .Number(number, pi):
            return (number + NSDecimalNumber.pi(pi)).description
        }
    }

    private func numDesc(num: NSDecimalNumber) -> String {
        if num > 100_000_000 {
            let powers: Int = floor(log(num.doubleValue))
            let exp = num / (NSDecimalNumber(int: 10) ^ powers)
            return exp.description + "×10^" + powers.description
        }
        return num.description
    }

    var description: String {
        switch self {
        case .DivZero: return "!/0"
        case .NeedsInput: return "..."
        case let .Number(number, pi):
            if pi == 0 {
                return numDesc(number.description)
            }
            else {
                let piDesc = (pi == 1 ? "" : numDesc(pi)) + "π"
                if number == NSDecimalNumber.zero() {
                    return piDesc
                }
                else {
                    return numDesc(number.description) + "+\(piDesc)"
                }
            }
        }
    }
}
