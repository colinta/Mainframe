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

    var toFraction: (Int, Int)? {
        switch self.split {
        case let (sign, num, 0):
            return (sign * num, 1)
        case let (sign, num, decimals):
            let decimalsLength = Double(decimals.description.count)
            if decimalsLength > 6 {
                return nil
            }
            let tenDenominator = Int(pow(10, decimalsLength))
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

    private var split: (Int, Int, Int) {
        guard self >= 0 else {
            let (_, a, b) = (-self).split
            return (-1, a, b)
        }
        switch description.split(separator: ".").headAndHeadAndTail {
        case let .some((lhs, rhs, _)):
            return (1, Int(String(lhs)) ?? .zero, Int(String(rhs)) ?? .zero)
        default:
            return (1, self.asInt, 0)
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
