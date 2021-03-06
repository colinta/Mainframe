////
/// VariableOperation.swift
//

struct VariableOperation: OperationValue {
    var minChildNodes: Int? { return 0 }
    var maxChildNodes: Int? { return 0 }
    var description: String { return name }
    let name: String

    init(_ name: String) {
        self.name = name
    }

    func formula(_: [MathNode], isTop: Bool) -> String {
        return name
    }

    func calculate(_ nodes: [MathNode], vars: VariableLookup, avoidRecursion: [String]) -> OperationResult {
        if name == "π" {
            return .number(ExactNumber(pi: 1))
        }
        else if name == "-π" {
            return .number(ExactNumber(pi: -1))
        }
        else if name == "τ" {
            return .number(ExactNumber(pi: 2))
        }
        else if name == "-τ" {
            return .number(ExactNumber(pi: -2))
        }
        else if name == "𝑒" {
            return .number(ExactNumber(whole: Decimal(string: "2.71828182845904523536028747135266249775724709369995")!))
        }
        return vars.valueForVariable(name, avoidRecursion: avoidRecursion)
    }
}
