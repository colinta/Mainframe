////
/// OperationResult.swift
//

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

struct ExactNumber: CustomDebugStringConvertible {
    var whole: Decimal = 0
    var pi: Decimal = 0
    var fraction: (Int, Int)?
    // actual number =  whole + numerator/denominator + pi * 3.1415...

    var hasWhole: Bool { whole != 0 || hasFraction }
    var hasFraction: Bool { if let fraction = fraction { return fraction.0 != 0 } else { return false } }
    var hasPi: Bool { pi != 0 }
    var isNan: Bool { whole == .nan || pi == .nan }
    var isZero: Bool { whole == 0 && pi == 0 }

    var fractionalPart: Decimal {
        guard let (numerator, denominator) = fraction else { return whole }
        return whole + numerator / denominator
    }
    var toDecimal: Decimal {
        return fractionalPart + pi.timesPi
    }

    var debugDescription: String {
        if let fraction = fraction {
            return ExactNumber(whole: whole, pi: pi).debugDescription + " \(fraction.0)/\(fraction.1)"
        }
        return whole.description + (pi > 0 ? " + \(pi.description)π" : "")
    }

    static let zero = ExactNumber()
    static let one = ExactNumber(whole: 1)

    static prefix func - (lhs: ExactNumber) -> ExactNumber {
        ExactNumber(whole: -lhs.whole, pi: -lhs.pi, fraction: lhs.fraction.map { (-$0.0, $0.1) })
    }

    static func - (_ lhs: ExactNumber, _ rhs: ExactNumber) -> ExactNumber {
        .add(lhs, -rhs)
    }

    static func + (_ lhs: ExactNumber, _ rhs: ExactNumber) -> ExactNumber {
        .add(lhs, rhs)
    }

    private static func add(_ lhs: ExactNumber, _ rhs: ExactNumber) -> ExactNumber {
        if let lhsFraction = lhs.fraction, let rhsFraction = rhs.fraction {
            let (mixed, (numerator, denominator)) = addFractions(lhsFraction, rhsFraction)
            let (simpleWhole, simpleFraction) = addWhole(lhs.whole + rhs.whole + mixed, numerator, denominator)
            return ExactNumber(whole: simpleWhole, pi: lhs.pi + rhs.pi, fraction: simpleFraction)
        }
        else if lhs.fraction != nil {
            return .add(lhs, ExactNumber(whole: rhs.fractionalPart, pi: rhs.pi, fraction: (0, 1)))
        }
        else if rhs.fraction != nil {
            return .add(ExactNumber(whole: lhs.fractionalPart, pi: lhs.pi, fraction: (0, 1)), rhs)
        }
        else {
            return ExactNumber(whole: lhs.fractionalPart + rhs.fractionalPart, pi: lhs.pi - rhs.pi)
        }
    }

    private static func addFractions(_ lhsFraction: (Int, Int), _ rhsFraction: (Int, Int)) -> (Decimal, (Int, Int)) {
        let gcdDenominator = gcd(lhsFraction.1, rhsFraction.1)
        let denominator = lhsFraction.1 * rhsFraction.1 / gcdDenominator
        let lhsMultiplier = lhsFraction.1 / gcdDenominator
        let rhsMultiplier = rhsFraction.1 / gcdDenominator
        let numerator = lhsFraction.0 * rhsMultiplier + lhsMultiplier * rhsFraction.0
        let finalNum = numerator % denominator
        let finalWhole = Decimal((numerator - finalNum) / denominator)
        // we have finalWhole + finalNum / denominator, simplify finalNum and denominator
        let simpleGcd = gcd(finalNum, denominator)
        return (finalWhole, (finalNum / simpleGcd, denominator / simpleGcd))
    }

    private static func addWhole(_ whole: Decimal, _ numerator: Int, _ denominator: Int) -> (Decimal, (Int, Int)?) {
        guard denominator != 0 else { return addWhole(whole, 0, 1) }
        guard whole != 0 else { return (0, (numerator, denominator)) }

        switch whole.toFraction {
        case nil:
            return (whole + Decimal(numerator) / Decimal(denominator), nil)
        case let .some(tenNumerator, tenDenominator):
            return addFractions((numerator, denominator), (tenNumerator, tenDenominator))
        }
    }
}

enum OperationResult: CustomStringConvertible {
    case nan
    case divZero
    case needsInput
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
            case let .number(exact):
                return exact.toDecimal.description
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
        case let .number(exact):
            if exact.pi == 0 {
                return numDesc(exact.toDecimal)
            }
            else if exact.pi == -1 && !useTau {
                return "-π"
            }
            else if exact.pi == -2 && useTau {
                return "-τ"
            }
            else {
                let piDesc: String
                if useTau {
                    piDesc = (exact.pi == 2 ? "" : numDesc(exact.pi < 0 ? -(exact.pi / 2) : (exact.pi / 2))) + "τ"
                }
                else {
                    piDesc = (exact.pi == 1 ? "" : numDesc(exact.pi < 0 ? -exact.pi : exact.pi)) + "π"
                }

                if !exact.hasWhole {
                    return piDesc
                }
                else if exact.pi < 0 {
                    return numDesc(exact.whole) + "-\(piDesc)"
                }
                else {
                    return numDesc(exact.whole) + "+\(piDesc)"
                }
            }
        }
    }

    var description: String {
        return exactDescription(useTau: false)
    }
}
