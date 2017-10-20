////
/// AcceptButton.swift
//

class AcceptButton: Button {

    required init() {
        super.init()
        setScale(0.5)
        text = "✓"
        size = CGSize(60)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
