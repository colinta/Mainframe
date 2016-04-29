//
//  ScaleToComponent.swift
//  FlatoutWar
//
//  Created by Colin Gray on 2/9/2016.
//  Copyright (c) 2016 FlatoutWar. All rights reserved.
//

class ScaleToComponent: ApplyToNodeComponent {
    var easing: Easing?
    var currentScale: CGFloat?
    var target: CGFloat? = 1 {
        didSet {
            if node != nil {
                currentScale = node.xScale
            }

            if _duration != nil && target != nil {
                _rate = nil
            }
        }
    }
    private var _rate: CGFloat? = 1.65
    var rate: CGFloat? {
        get { return _rate }
        set {
            _rate = newValue
            if newValue != nil {
                _duration = nil
            }
        }
    }
    private var _duration: CGFloat?
    var duration: CGFloat? {
        get { return _duration }
        set {
            _duration = newValue
            if newValue != nil {
                _rate = nil
            }
        }
    }

    convenience init(scaleOut duration: CGFloat) {
        self.init()
        target = 0
        self.duration = duration
        removeNodeOnScale()
    }

    convenience init(scaleIn duration: CGFloat) {
        self.init()
        target = 1
        self.duration = duration
        removeNodeOnScale()
    }

    typealias OnScaled = Block
    private var _onScaled: [OnScaled] = []
    func onScaled(handler: OnScaled) {
        _onScaled << handler
    }

    override func defaultApplyTo() {
        super.defaultApplyTo()
        currentScale = node.xScale
    }

    override func reset() {
        super.reset()
        _onScaled = []
    }

    func removeComponentOnScale() {
        self.onScaled(removeFromNode)
    }

    func removeNodeOnScale() {
        self.onScaled {
            guard let node = self.node else { return }
            node.removeFromParent()
        }
    }

    override func update(dt: CGFloat) {
        guard let target = target, currentScale = currentScale else { return }

        let rate: CGFloat
        if let _rate = _rate {
            rate = _rate
        }
        else if let duration = _duration
        where duration > 0 {
            rate = (target - currentScale) / duration
            _rate = rate
        }
        else {
            return
        }

        if let newScale = moveValue(currentScale, towards: target, by: rate * dt) {
            self.currentScale = newScale

            apply { applyTo in
                let actualScale: CGFloat
                if let easing = self.easing {
                    actualScale = easing.ease(time: newScale, initial: 0, final: 1)
                }
                else {
                    actualScale = newScale
                }

                applyTo.setScale(actualScale)
            }
        }
        else {
            self.currentScale = target
            self.target = nil

            for handler in _onScaled {
                handler()
            }
        }
    }

}


extension Node {

    func scaleTo(targetScale: CGFloat, start: CGFloat? = nil, duration: CGFloat? = nil, rate: CGFloat? = nil, removeNode: Bool = false, easing: Easing? = nil) -> ScaleToComponent {
        let scale = scaleToComponent ?? ScaleToComponent()
        if let start = start {
            self.setScale(start)
            scale.currentScale = start
        }
        else {
            scale.currentScale = self.xScale
        }
        scale.target = targetScale
        scale.duration = duration
        scale.rate = rate
        scale.easing = easing

        if removeNode {
            scale.removeNodeOnScale()
        }
        else {
            scale.removeComponentOnScale()
        }

        if scaleToComponent == nil {
            addComponent(scale)
        }

        return scale
    }
}
