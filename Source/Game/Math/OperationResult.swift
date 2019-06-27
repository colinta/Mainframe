////
/// OperationResult.swift
//

enum OperationResult {
    case nan
    case divZero
    case needsInput
    case number(number: Decimal, pi: Decimal)

    static func checkNumber(number: Decimal, pi: Decimal) -> OperationResult {
        if number == Decimal.nan || pi == Decimal.nan {
            return .nan
        }
        return .number(number: number, pi: pi)
    }

    var number: String {
        switch self {
        case .nan, .divZero, .needsInput: return description
        case let .number(number, numberPi):
            return (number + Decimal.pi(times: numberPi)).description
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

    var description: String {
        switch self {
        case .nan: return "NaN"
        case .divZero: return "UNDEF"
        case .needsInput: return "..."
        case let .number(number, pi):
            if pi == 0 {
                return numDesc(number)
            }
            else {
                let piDesc = (pi == 1 ? "" : numDesc(pi)) + "π"
                if number == Decimal(0) {
                    return piDesc
                }
                else {
                    return numDesc(number) + "+\(piDesc)"
                }
            }
        }
    }
}
