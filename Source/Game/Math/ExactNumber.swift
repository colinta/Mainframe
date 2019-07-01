////
///  ExactNumber.swift
//

struct ExactNumber: CustomDebugStringConvertible {
    var whole: Decimal = 0
    var pi: Decimal = 0
    var fraction: (Int, Int)?
    // actual number =  whole + numerator/denominator + pi * 3.1415...

    var hasDecimal: Bool { whole != 0 || hasFraction }
    var hasFraction: Bool { fraction != nil }
    var hasPi: Bool { pi != 0 }
    var isNan: Bool { whole == .nan || pi == .nan }
    var isZero: Bool { whole == 0 && pi == 0 }

    var fractionalPart: Decimal {
        guard let (numerator, denominator) = fraction, denominator != 0 else { return whole }
        return whole + Decimal(numerator) / Decimal(denominator)
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

    func reduce(tryFraction: Bool = true) -> ExactNumber {
        guard tryFraction, let wholeFraction = whole.asFraction else {
            return ExactNumber(whole: fractionalPart, pi: pi)
        }

        let fraction = self.fraction ?? (0, 1)
        let (simplifiedWhole, simplifiedFraction) = ExactNumber.addFractions(wholeFraction, fraction)
        return ExactNumber(whole: simplifiedWhole, pi: pi, fraction: simplifiedFraction)
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
            return ExactNumber(whole: lhs.fractionalPart + rhs.fractionalPart, pi: lhs.pi + rhs.pi)
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

        switch whole.asFraction {
        case nil:
            return (whole + Decimal(numerator) / Decimal(denominator), nil)
        case let .some(tenNumerator, tenDenominator):
            return addFractions((numerator, denominator), (tenNumerator, tenDenominator))
        }
    }
}
