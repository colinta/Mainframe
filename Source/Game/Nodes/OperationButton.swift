////
/// OperationButton.swift
//

class OperationButton: Button {
    let op: Operation

    required init(op: Operation) {
        self.op = op
        super.init()
    }

    convenience required init() {
        self.init(op: .NoOp)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
