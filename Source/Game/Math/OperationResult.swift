////
/// OperationResult.swift
//

enum OperationResult {
    case NaN
    case DivZero
    case NeedsInput
    case Number(number: Decimal, pi: Decimal)

    static func CheckNumber(number: Decimal, pi: Decimal) -> OperationResult {
        if number == Decimal.nan || pi == Decimal.nan {
            return .NaN
        }
        return .Number(number: number, pi: pi)
    }

    var number: String {
        switch self {
        case .NaN, .DivZero, .NeedsInput: return description
        case let .Number(number, numberPi):
            return (number + Decimal.pi(times: numberPi)).description
        }
    }

    private func numDesc(_ num: Decimal) -> String {
        if num > 100_000_000 {
            let power: Int = Int(floor(log10(num.asDouble)))
            let exp: Decimal = num / pow(10, power)
            var expStr = exp.description
            let powStr = power.description
            let charCount = expStr.characters.count + powStr.characters.count
            let maxCount = 17
            if charCount > maxCount {
                let begin = expStr.startIndex
                var end = expStr.startIndex
                (maxCount - powStr.characters.count).times { end = expStr.index(after: end) }
                expStr = String(expStr[begin..<end])
            }
            return expStr.withCommas() + "𝚎" + powStr
        }
        return num.description.withCommas()
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
