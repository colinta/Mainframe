////
/// NoOperation.swift
//

struct NoOperation: OperationValue {
    var description: String { return "" }
    var minChildNodes: Int? = 0
    var maxChildNodes: Int? = 0
}
