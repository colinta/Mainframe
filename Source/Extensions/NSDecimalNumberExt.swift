// MARK: - Comparable

extension NSDecimalNumber {
    static func pi(times: NSDecimalNumber = NSDecimalNumber.one()) -> NSDecimalNumber {
        if times == 0 { return NSDecimalNumber.zero() }
        return NSDecimalNumber(string: "3.14159265358979323846264338327950288419716939937510582") * times
    }
    static func tau(times: NSDecimalNumber = NSDecimalNumber.one()) -> NSDecimalNumber {
        if times == 0 { return NSDecimalNumber.zero() }
        return NSDecimalNumber.pi(times) * NSDecimalNumber(integer: 2)
    }
}

extension NSDecimalNumber: Comparable {}

public func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

// MARK: - Arithmetic Operators

public prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
    return value.decimalNumberByMultiplyingBy(NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
}

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByAdding(rhs)
}

public func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberBySubtracting(rhs)
}

public func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByMultiplyingBy(rhs)
}

public func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByDividingBy(rhs)
}

public func ^(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.decimalNumberByRaisingToPower(rhs)
}

// MARK: - Int compatibility

public func +(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.decimalNumberByAdding(NSDecimalNumber(integer: rhs))
}

public func -(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.decimalNumberBySubtracting(NSDecimalNumber(integer: rhs))
}

public func *(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: rhs))
}

public func /(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.decimalNumberByDividingBy(NSDecimalNumber(integer: rhs))
}

public func +(lhs: Int, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return NSDecimalNumber(integer: lhs).decimalNumberByAdding(rhs)
}

public func -(lhs: Int, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return NSDecimalNumber(integer: lhs).decimalNumberBySubtracting(rhs)
}

public func *(lhs: Int, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return NSDecimalNumber(integer: lhs).decimalNumberByMultiplyingBy(rhs)
}

public func /(lhs: Int, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return NSDecimalNumber(integer: lhs).decimalNumberByDividingBy(rhs)
}
