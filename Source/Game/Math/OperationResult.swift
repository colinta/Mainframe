//
//  OperationResult.swift
//  Mainframe
//
//  Created by Colin Gray on 4/24/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

enum OperationResult {
    case NaN
    case DivZero
    case NeedsInput
    case Number(number: NSDecimalNumber, pi: NSDecimalNumber)

    static func CheckNumber(number number: NSDecimalNumber, pi: NSDecimalNumber) -> OperationResult {
        if number == NSDecimalNumber.notANumber() || pi == NSDecimalNumber.notANumber() {
            return .NaN
        }
        return .Number(number: number, pi: pi)
    }

    var number: String {
        switch self {
        case .NaN, .DivZero, .NeedsInput: return description
        case let .Number(number, pi):
            return (number + NSDecimalNumber.pi(pi)).description
        }
    }

    private func numDesc(num: NSDecimalNumber) -> String {
        if num > 100_000_000 {
            let pow: Int = Int(floor(log10(num.doubleValue)))
            let exp = num / (NSDecimalNumber(int: 10) ^ pow)
            let expStr = exp.description
            let powStr = pow.description
            let charCount = expStr.characters.count + powStr.characters.count
            let maxCount = 17
            if charCount > maxCount {
                let begin = expStr.startIndex
                var end = expStr.startIndex
                (maxCount - powStr.characters.count).times { end = end.successor() }
                return expStr[begin..<end] + "𝚎" + powStr
            }
            return expStr + "𝚎" + powStr
        }
        return num.description
    }

    var description: String {
        switch self {
        case .NaN: return "NaN"
        case .DivZero: return "!/0"
        case .NeedsInput: return "..."
        case let .Number(number, pi):
            if pi == 0 {
                return numDesc(number)
            }
            else {
                let piDesc = (pi == 1 ? "" : numDesc(pi)) + "π"
                if number == NSDecimalNumber.zero() {
                    return piDesc
                }
                else {
                    return numDesc(number) + "+\(piDesc)"
                }
            }
        }
    }
}
