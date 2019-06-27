////
/// SelectableComponent.swift
//

class SelectableComponent: Component {
    var isSelected = false
    private var selecting = false

    typealias OnSelected = (Bool) -> Void
    typealias SimpleOnSelected = (Bool) -> Void
    var _onSelected: [OnSelected] = []

    override func reset() {
        super.reset()
        _onSelected = []
    }

    func bindTo(touchableComponent: TouchableComponent) {
        touchableComponent.on(.downInside, onTouchIn)
        touchableComponent.on(.pressed, onTouchPressed)
        touchableComponent.on(.up, onTouchEnded)
    }

    func changeSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
        selectedHandler(isSelected)
    }

    func onSelected(_ handler: @escaping SimpleOnSelected) {
        _onSelected.append(handler)
    }

    func onTouchIn(location: CGPoint) {
        guard isEnabled else { return }

        if node.world?.selectedNode != node {
            node.world?.selectNode(node)
            selecting = true
        }
    }

    func onTouchPressed(location: CGPoint) {
        guard isEnabled else { return }

        if !selecting {
            node.world?.unselectNode(node)
        }
    }

    func onTouchEnded(location: CGPoint) {
        selecting = false
    }

    private func selectedHandler(_ isSelected: Bool) {
        for handler in _onSelected {
            handler(isSelected)
        }
    }

}
