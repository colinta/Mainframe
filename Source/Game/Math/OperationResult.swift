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

    var description: String {
        switch self {
        case .DivZero: return "!/0"
        case .NeedsInput: return "..."
        case let .Number(number, pi):
            if pi == 0 {
                return number.description
            }
            else {
                let piDesc = (pi == 1 ? "" : String(pi)) + "π"
                if number == NSDecimalNumber.zero() {
                    return piDesc
                }
                else {
                    return number.description + "+\(piDesc)"
                }
            }
        }
    }
}
