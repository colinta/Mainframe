//
//  SelectableComponent.swift
//  FlatoutWar
//
//  Created by Colin Gray on 12/28/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
//

class SelectableComponent: Component {
    var selected = false
    private var selecting = false

    typealias OnSelected = (Bool) -> Void
    typealias SimpleOnSelected = (Bool) -> Void
    var _onSelected: [OnSelected] = []

    override func reset() {
        super.reset()
        _onSelected = []
    }

    func bindTo(touchableComponent touchableComponent: TouchableComponent) {
        touchableComponent.on(.DownInside, onTouchIn)
        touchableComponent.on(.Pressed, onTouchPressed)
        touchableComponent.on(.Up, onTouchEnded)
    }

    func changeSelected(selected: Bool) {
        self.selected = selected
        for handler in _onSelected {
            handler(selected)
        }
    }

    func onSelected(handler: SimpleOnSelected) {
        _onSelected << { selected in handler(selected) }
    }

    func onTouchIn(location: CGPoint) {
        guard enabled else { return }

        if node.world?.selectedNode != node {
            node.world?.selectNode(node)
            selecting = true
        }
    }

    func onTouchPressed(location: CGPoint) {
        guard enabled else { return }

        if !selecting {
            node.world?.unselectNode(node)
        }
    }

    func onTouchEnded(location: CGPoint) {
        selecting = false
    }

    func selectedHandler(selected: Bool) {
        for handler in _onSelected {
            handler(selected)
        }
    }

}
