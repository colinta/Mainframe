// MARK: - Comparable

extension Decimal {
    var asDouble: Double {
        return (self as NSDecimalNumber).doubleValue
    }

    static func pi(times: Decimal = Decimal(1)) -> Decimal {
        if times == 0 { return Decimal(0) }
        return Decimal(string: "3.14159265358979323846264338327950288419716939937510582")! * times
    }
    static func tau(times: Decimal = Decimal(1)) -> Decimal {
        if times == 0 { return Decimal(0) }
        return Decimal.pi(times: times) * Decimal(2)
    }
}

// MARK: - Int compatibility

public func +(lhs: Decimal, rhs: Int) -> Decimal {
    return lhs + Decimal(rhs)
}

public func -(lhs: Decimal, rhs: Int) -> Decimal {
    return lhs - Decimal(rhs)
}

public func *(lhs: Decimal, rhs: Int) -> Decimal {
    return lhs * Decimal(rhs)
}

public func /(lhs: Decimal, rhs: Int) -> Decimal {
    return lhs / Decimal(rhs)
}

public func +(lhs: Int, rhs: Decimal) -> Decimal {
    return Decimal(lhs) + rhs
}

public func -(lhs: Int, rhs: Decimal) -> Decimal {
    return Decimal(lhs) - rhs
}

public func *(lhs: Int, rhs: Decimal) -> Decimal {
    return Decimal(lhs) * rhs
}

public func /(lhs: Int, rhs: Decimal) -> Decimal {
    return Decimal(lhs) / rhs
}
