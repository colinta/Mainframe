////
/// OperationResult.swift
//

typealias NumberPlusPi = (number: Decimal, pi: Decimal)

enum OutputStyle {
    case exact
    case number
    case woodworking

    var next: OutputStyle {
        switch self {
        case .exact:
            return .number
        case .number:
            return .woodworking
        case .woodworking:
            return .exact
        }
    }
}


enum OperationResult: CustomStringConvertible {
    case nan
    case divZero
    case needsInput
    case number(number: Decimal, pi: Decimal)

    static func map2(_ lhsVal: OperationResult, _ rhsVal: OperationResult,
        _ fn: (Decimal, Decimal) -> Decimal) -> OperationResult
    {
        switch (lhsVal, rhsVal) {
        case (.nan, _), (.divZero, _), (.needsInput, _): return lhsVal
        case (_, .nan), (_, .divZero), (_, .needsInput): return rhsVal
        case let (.number(number: lhsNumber, pi: lhsPi), .number(rhsNumber, rhsPi)):
            let lhs = lhsNumber + lhsPi.timesPi
            let rhs = rhsNumber + rhsPi.timesPi
            let result = fn(lhs, rhs)
            return .checkNumber(number: result, pi: 0)
        default:
            return .needsInput
        }
    }

    static func checkNumber(number: Decimal, pi: Decimal) -> OperationResult {
        if number == Decimal.nan || pi == Decimal.nan {
            return .nan
        }
        return .number(number: number, pi: pi)
    }

    func map(_ fn: (Decimal, Decimal) -> NumberPlusPi) -> OperationResult {
        switch self {
        case .nan, .divZero, .needsInput:
            return self
        case let .number(number, numberPi):
            let (dec, pi) = fn(number, numberPi)
            return .checkNumber(number: dec, pi: pi)
        }
    }

    func mapDecimal(_ fn: (Decimal) -> Decimal) -> OperationResult {
        return self.map { number, numberPi in
            let result = fn(number + numberPi.timesPi)
            return (number: result, pi: 0)
        }
    }

    func flatMap(_ fn: (Decimal, Decimal) -> OperationResult) -> OperationResult {
        switch self {
        case .nan, .divZero, .needsInput:
            return self
        case let .number(number, numberPi):
            return fn(number, numberPi)
        }
    }

    private func numDesc(_ num: Decimal) -> String {
        if num > 100_000_000 {
            let power: Int = Int(floor(log10(num.asDouble)))
            let exp: Decimal = num / pow(10, power)
            var expStr = exp.description
            let powStr = power.description
            let charCount = expStr.count + powStr.count
            let maxCount = 17
            if charCount > maxCount {
                let begin = expStr.startIndex
                var end = expStr.startIndex
                (maxCount - powStr.count).times { end = expStr.index(after: end) }
                expStr = String(expStr[begin..<end])
            }
            return expStr.withCommas() + "𝚎" + powStr
        }
        return num.description.withCommas()
    }

    func describe(style: OutputStyle, useTau: Bool) -> String {
        switch style {
        case .exact:
            return exactDescription(useTau: useTau)
        case .number:
            switch self {
            case .nan, .divZero, .needsInput: return description
            case let .number(number, numberPi):
                return (number + numberPi.timesPi).description
            }
        case .woodworking:
            return describe(style: .number, useTau: useTau)
        }
    }

    private func exactDescription(useTau: Bool) -> String {
        switch self {
        case .nan: return "NaN"
        case .divZero: return "UNDEF"
        case .needsInput: return "..."
        case let .number(number, pi):
            if pi == 0 {
                return numDesc(number)
            }
            else if pi == -1 && !useTau {
                return "-π"
            }
            else if pi == -2 && useTau {
                return "-τ"
            }
            else if useTau {
                let piDesc = (pi == 2 ? "" : numDesc(pi < 0 ? -(pi / 2) : (pi / 2))) + "τ"
                if number == 0 {
                    return piDesc
                }
                else if pi < 0 {
                    return numDesc(number) + "-\(piDesc)"
                }
                else {
                    return numDesc(number) + "+\(piDesc)"
                }
            }
            else {
                let piDesc = (pi == 1 ? "" : numDesc(pi < 0 ? -pi : pi)) + "π"
                if number == 0 {
                    return piDesc
                }
                else if pi < 0 {
                    return numDesc(number) + "-\(piDesc)"
                }
                else {
                    return numDesc(number) + "+\(piDesc)"
                }
            }
        }
    }

    var description: String {
        return exactDescription(useTau: false)
    }
}
