////
/// OperationResult.swift
//

enum OperationResult: CustomStringConvertible {
    case nan
    case divZero
    case needsInput
    case skip
    case number(ExactNumber)

    static func map2(_ lhsVal: OperationResult, _ rhsVal: OperationResult,
        _ fn: (Decimal, Decimal) -> Decimal) -> OperationResult
    {
        map2(lhsVal, rhsVal) { (lhs: ExactNumber, rhs: ExactNumber) -> ExactNumber in
            ExactNumber(whole: fn(lhs.toDecimal, rhs.toDecimal))
        }
    }

    static func map2(_ lhsVal: OperationResult, _ rhsVal: OperationResult,
        _ fn: (ExactNumber, ExactNumber) -> ExactNumber) -> OperationResult
    {
        switch (lhsVal, rhsVal) {
        case (.nan, _), (.divZero, _), (.needsInput, _): return lhsVal
        case (_, .nan), (_, .divZero), (_, .needsInput): return rhsVal
        case (.skip, _), (_, .skip): return .needsInput
        case let (.number(lhsExact), .number(rhsExact)):
            let result = fn(lhsExact, rhsExact)
            return .checkNaN(result)
        default:
            return .needsInput
        }
    }

    static func reduce(_ values: [OperationResult],
        _ fn: (ExactNumber, ExactNumber) -> ExactNumber) -> OperationResult
    {
        var result: ExactNumber = .zero
        for value in values {
            switch value {
            case .nan, .divZero, .needsInput: return value
            case .skip: break
            case let .number(exact):
                result = fn(result, exact)
            }
        }
        return .checkNaN(result)
    }

    static func checkNaN(_ exact: ExactNumber) -> OperationResult {
        if exact.isNan {
            return .nan
        }
        return .number(exact)
    }

    func map(_ fn: (ExactNumber) -> ExactNumber) -> OperationResult {
        switch self {
        case .nan, .divZero, .needsInput:
            return self
        case .skip:
            return .needsInput
        case let .number(exact):
            let result = fn(exact)
            return .checkNaN(result)
        }
    }

    func mapDecimal(_ fn: (Decimal) -> Decimal) -> OperationResult {
        return self.map { exact in
            let result = fn(exact.toDecimal)
            return ExactNumber(whole: result)
        }
    }

    private func numDesc(_ num: Decimal, _ fraction: (Int, Int)? = nil) -> String {
        if let (numerator, denominator) = fraction, numerator != 0 {
            let numberDesc = numDesc(num)
            if numberDesc.isEmpty || numberDesc == "0" {
                return "\(numerator)/\(denominator)"
            }
            else if num < 0 && numerator < 0 {
                return "\(numberDesc) \(-numerator)/\(denominator)"
            }
            else {
                return "\(numberDesc) \(numerator)/\(denominator)"
            }
        }

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
            case .nan, .divZero, .needsInput, .skip: return description
            case let .number(exact):
                return exact.toDecimal.description
            }
        }
    }

    private func exactDescription(useTau: Bool) -> String {
        switch self {
        case .nan: return "NaN"
        case .divZero: return "◻/0!"
        case .needsInput, .skip: return "..."
        case let .number(exact):
            if exact.pi == 0 {
                return numDesc(exact.whole, exact.fraction)
            }
            else {
                let piDesc: String
                switch (useTau, exact.pi) {
                case (true, -2):
                    piDesc = "-τ"
                case (true, 2):
                    piDesc = "τ"
                case (true, _):
                    piDesc = numDesc(exact.pi < 0 ? -(exact.pi / 2) : (exact.pi / 2)) + "τ"
                case (false, -1):
                    piDesc = "-π"
                case (false, 1):
                    piDesc = "π"
                case (false, _):
                    piDesc = numDesc(exact.pi < 0 ? -exact.pi : exact.pi) + "π"
                }

                if !exact.hasDecimal {
                    return piDesc
                }
                else if exact.pi < 0 {
                    return numDesc(exact.whole, exact.fraction) + "-\(piDesc)"
                }
                else {
                    return numDesc(exact.whole, exact.fraction) + "+\(piDesc)"
                }
            }
        }
    }

    var description: String {
        return exactDescription(useTau: false)
    }
}
