////
/// NextOperation.swift
//

struct NextOperation: OperationValue {
    var minChildNodes: Int? { return 0 }
    var maxChildNodes: Int? { return 0 }
    var description: String = "→"
}
