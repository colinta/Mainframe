////
///  WoodworkingOperation.swift
//

struct WoodworkingOperation: OperationValue {
    var minChildNodes: Int? { return 0 }
    var maxChildNodes: Int? { return 0 }
    let description: String
    let number: Decimal?
    let numerator: Int?
    let denominator: Int?

    init(_ numberString: String, numerator numeratorString: String, denominator denominatorString: String) {
        if let whole = Decimal(string: numberString),
            let numerator = Int(numeratorString),
            let denominator = Int(denominatorString)
        {
            self.description = "\(numberString.isEmpty ? "" : numberString.withCommas() + " ")\(numeratorString.withCommas())/\(denominatorString.withCommas())"
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
            self.description = "\(numeratorString.withCommas())/\(denominatorString.withCommas())"
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
            self.description = "\(numberString.withCommas()) \(numeratorString.isEmpty ? "◻" : numeratorString)/\(denominatorString.isEmpty ? "◻" : denominatorString)"
            self.numerator = nil
            self.denominator = nil
            self.number = whole
        }
        else {
            self.description = "\(numberString.isEmpty ? "" : numberString + " ")\(numeratorString.isEmpty ? "◻" : numeratorString)/\(denominatorString.isEmpty ? "◻" : denominatorString)"
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
            return .number(ExactNumber(whole: number, fraction: (numerator, denominator)).reduce())
        }
        else if let number = number {
            return .number(ExactNumber(whole: number).reduce())
        }
        return .needsInput
    }
}
