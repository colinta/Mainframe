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

    func calculate(_ nodes: [MathNode], vars: VariableLookup) -> OperationResult {
        if name == "π" {
            return .Number(number: 0, pi: 1)
        }
        else if name == "τ" {
            return .Number(number: 0, pi: 2)
        }
        else if name == "𝑒" {
            return .Number(number: Decimal(string: "2.71828182845904523536028747135266249775724709369995")!, pi: 0)
        }
        return vars.valueForVariable(name)
    }
}
