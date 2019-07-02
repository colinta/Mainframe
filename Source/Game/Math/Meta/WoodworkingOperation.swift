////
///  WoodworkingOperation.swift
//

struct WoodworkingOperation: OperationValue {
    var minChildNodes: Int? { return 0 }
    var maxChildNodes: Int? { return 0 }
    let description: String

    let sign: Sign
    let number: Decimal?
    let numerator: Int?
    let denominator: Int?

    init(_ sign: Sign, _ numberString: String, numerator numeratorString: String, denominator denominatorString: String) {
        self.sign = sign

        if let whole = Decimal(string: numberString),
            whole != 0,
            let numerator = Int(numeratorString),
            let denominator = Int(denominatorString)
        {
            let signedNumberString = sign * numberString
            self.description = "\(signedNumberString.isEmpty ? "" : signedNumberString.withCommas() + " ")\(numeratorString.withCommas())/\(denominatorString.withCommas())"
            self.numerator = numerator
            self.denominator = denominator

            if denominator == 0 {
                self.number = .nan
            }
            else {
                self.number = whole
            }
        }
        else if let numerator = Int(numeratorString),
            let denominator = Int(denominatorString)
        {
            let signedNumeratorString = sign * numeratorString
            self.description = "\(signedNumeratorString.withCommas())/\(denominatorString.withCommas())"
            self.numerator = numerator
            self.denominator = denominator

            if denominator == 0 {
                self.number = .nan
            }
            else {
                self.number = 0
            }
        }
        else if let whole = Decimal(string: numberString) {
            let numeratorDesc = numeratorString.isEmpty ? "◻" : numeratorString
            let denominatorDesc = denominatorString.isEmpty ? "◻" : denominatorString
            if numberString.isEmpty || numberString == "0" {
                self.description = "\(numeratorDesc)/\(denominatorDesc)"
            }
            else {
                let signedNumberString = sign * numberString
                self.description = "\(signedNumberString.withCommas()) \(numeratorDesc)/\(denominatorDesc)"
            }
            self.numerator = nil
            self.denominator = nil
            self.number = whole
        }
        else {
            let numeratorDesc = numeratorString.isEmpty ? "◻" : numeratorString
            let denominatorDesc = denominatorString.isEmpty ? "◻" : denominatorString
            if numberString.isEmpty {
                self.description = "\(sign * numeratorDesc)/\(denominatorDesc)"
            }
            else {
                self.description = "\(sign * numberString) \(numeratorDesc)/\(denominatorDesc)"
            }
            self.number = nil
            self.numerator = nil
            self.denominator = nil
        }
    }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        return description
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        if let number = number, let numerator = numerator, let denominator = denominator {
            return .number(ExactNumber(whole: sign * number, fraction: (sign * numerator, denominator)).reduce())
        }
        else if let number = number {
            return .number(ExactNumber(whole: sign * number).reduce())
        }
        return .skip
    }

    func description(editing: MathNode.Editing) -> String {
        if editing == .numerator {
            return description.replacingOccurrences(of: "◻/", with: "◼/")
        }
        else if editing == .denominator {
            return description.replacingOccurrences(of: "/◻", with: "/◼")
        }
        else {
            return description
        }
    }
}
