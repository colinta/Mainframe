//
//  FadeToComponent.swift
//  FlatoutWar
//
//  Created by Colin Gray on 12/29/15.
//  Copyright © 2015 colinta. All rights reserved.
//

class FadeToComponent: ApplyToNodeComponent {
    var currentAlpha: CGFloat?
    var target: CGFloat? = 1 {
        didSet {
            if _duration != nil {
                _rate = nil
            }
        }
    }
    private var _rate: CGFloat? = 1.65  // 0.6s
    var rate: CGFloat? {
        get { return _rate }
        set {
            _rate = newValue
        }
    }
    private var _duration: CGFloat?
    var duration: CGFloat? {
        get { return _duration }
        set {
            _duration = newValue
            _rate = nil
        }
    }

    convenience init(fadeOut duration: CGFloat) {
        self.init()
        target = 0
        self.duration = duration
        removeNodeOnFade()
    }

    convenience init(fadeIn duration: CGFloat) {
        self.init()
        target = 1
        self.duration = duration
        removeNodeOnFade()
    }

    typealias OnFaded = Block
    private var _onFaded: [OnFaded] = []
    func onFaded(handler: OnFaded) {
        _onFaded << handler
    }

    override func defaultApplyTo() {
        super.defaultApplyTo()
        currentAlpha = node.alpha
    }

    override func reset() {
        super.reset()
        _onFaded = []
    }

    func removeComponentOnFade() {
        self.onFaded(removeFromNode)
    }

    func removeNodeOnFade() {
        self.onFaded {
            guard let node = self.node else { return }
            node.removeFromParent()
        }
    }

    override func update(dt: CGFloat) {
        guard let target = target else { return }
        guard let currentAlpha = currentAlpha else { return }

        let rate: CGFloat
        if let _rate = _rate {
            rate = _rate
        }
        else if let duration = _duration {
            rate = CGFloat(abs(target - currentAlpha)) / duration
            _rate = rate
        }
        else {
            rate = 0
        }

        if let newAlpha = moveValue(currentAlpha, towards: target, by: rate * dt) {
            self.currentAlpha = newAlpha

            apply { applyTo in
                applyTo.alpha = newAlpha
            }
        }
        else {
            self.currentAlpha = target
            self.target = nil

            for handler in _onFaded {
                handler()
            }
            _onFaded = []
        }
    }

}


extension Node {

    func fadeTo(alpha: CGFloat, start: CGFloat? = nil, duration: CGFloat? = nil, rate: CGFloat? = nil, removeNode: Bool = false) -> FadeToComponent {
        let fade = fadeToComponent ?? FadeToComponent()
        if let start = start {
            self.alpha = start
            fade.currentAlpha = start
        }
        else {
            fade.currentAlpha = self.alpha
        }
        fade.target = alpha
        fade.duration = duration
        fade.rate = rate

        if removeNode {
            fade.removeNodeOnFade()
        }
        else {
            fade.removeComponentOnFade()
        }

        if fadeToComponent == nil {
            addComponent(fade)
        }

        return fade
    }
}
