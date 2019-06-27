////
/// NumberOperation.swift
//

struct NumberOperation: OperationValue {
    var minChildNodes: Int? { return 0 }
    var maxChildNodes: Int? { return 0 }
    let description: String
    let number: Decimal?

    init(_ numberString: String) {
        if let dec = Decimal(string: numberString) {
            self.description = numberString.withCommas()

            self.number = dec
        }
        else {
            self.description = numberString
            self.number = nil
        }
    }

    func formula(_ nodes: [MathNode], isTop: Bool) -> String {
        return description
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        if let number = number {
            return .number(number: number, pi: 0)
        }
        return .needsInput
    }
}
