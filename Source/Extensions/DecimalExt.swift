// MARK: - Comparable

extension Decimal {
    var asDouble: Double {
        return (self as NSDecimalNumber).doubleValue
    }

    var asInt: Int {
        return (self as NSDecimalNumber).intValue
    }

    var timesPi: Decimal {
        return Decimal.pi(times: self)
    }

    var asFraction: (Int, Int)? {
        switch self.split {
        case let (sign, num, 0, 0):
            return (sign * num, 1)
        case let (sign, num, decimalsLength, decimals):
            if decimalsLength > 6 {  // up to 1/64 resolution, or 0.015625
                return nil
            }
            let tenDenominator = Int(pow(10, Double(decimalsLength)))
            let tenNumerator = sign * (num * tenDenominator + decimals)
            let tenGcd = gcd(tenNumerator, tenDenominator)
            return (tenNumerator / tenGcd, tenDenominator / tenGcd)
        }
    }

    func mapDouble(_ fn: (Double) -> Double) -> Decimal {
        return Decimal(fn(self.asDouble))
    }

    static func pi(times: Decimal = 1) -> Decimal {
        if times == 0 { return 0 }
        return Decimal.pi * times
    }

    static func tau(times: Decimal = 1) -> Decimal {
        if times == 0 { return 0 }
        return Decimal.pi(times: times) * Decimal(2)
    }

    private var split: (sign: Int, num: Int, decimalLength: Int, decimals: Int) {
        guard self >= 0 else {
            let (_, a, b, c) = (-self).split
            return (sign: -1, num: a, decimalLength: b, decimals: c)
        }
        switch description.split(separator: ".").headAndHeadAndTail {
        case let .some((lhs, rhs, _)):
            let numStr = String(lhs)
            let decimalStr = String(rhs)
            return (sign: 1, num: Int(numStr) ?? .zero, decimalLength: decimalStr.count, decimals: Int(decimalStr) ?? .zero)
        default:
            return (sign: 1, num: self.asInt, decimalLength: 0, decimals: 0)
        }
    }
}

// MARK: - Int compatibility

public func + (lhs: Decimal, rhs: Int) -> Decimal {
    return lhs + Decimal(rhs)
}

public func - (lhs: Decimal, rhs: Int) -> Decimal {
    return lhs - Decimal(rhs)
}

public func * (lhs: Decimal, rhs: Int) -> Decimal {
    return lhs * Decimal(rhs)
}

public func / (lhs: Decimal, rhs: Int) -> Decimal {
    return lhs / Decimal(rhs)
}

public func + (lhs: Int, rhs: Decimal) -> Decimal {
    return Decimal(lhs) + rhs
}

public func - (lhs: Int, rhs: Decimal) -> Decimal {
    return Decimal(lhs) - rhs
}

public func * (lhs: Int, rhs: Decimal) -> Decimal {
    return Decimal(lhs) * rhs
}

public func / (lhs: Int, rhs: Decimal) -> Decimal {
    return Decimal(lhs) / rhs
}
