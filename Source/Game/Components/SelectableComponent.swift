//
//  SelectableComponent.swift
//  FlatoutWar
//
//  Created by Colin Gray on 12/28/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
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
        touchableComponent.on(.DownInside, onTouchIn)
        touchableComponent.on(.Pressed, onTouchPressed)
        touchableComponent.on(.Up, onTouchEnded)
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
