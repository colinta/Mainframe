//
//  PhaseComponent.swift
//  FlatoutWar
//
//  Created by Colin Gray on 1/1/2016.
//  Copyright (c) 2016 FlatoutWar. All rights reserved.
//

class PhaseComponent: Component {
    var loops = false
    var easing = Easing.Linear
    private var _phase: CGFloat = 0
    var phase: CGFloat {
        get { return easing.ease(time: _phase, initial: 0, final: 1) }
        set { _phase = newValue }
    }
    var duration: CGFloat = 0

    typealias OnPhase = (phase: CGFloat) -> Void
    private var _onPhase: [OnPhase] = []
    func onPhase(handler: OnPhase) {
        _onPhase << handler
    }

    typealias OnValue = (value: CGFloat) -> Void
    private var _onValue: [OnValue] = []
    func onValue(handler: OnValue) {
        _onValue << handler
    }

    var value: CGFloat { return startValue + (finalValue - startValue) * phase }
    var startValue: CGFloat = 0
    var finalValue: CGFloat = 1

    override func reset() {
        super.reset()
        _onPhase = []
        _onValue = []
    }

    override func update(dt: CGFloat) {
        guard duration > 0 else { return }

        _phase = (_phase + dt / duration)
        if loops {
            _phase = _phase % 1.0
        }
        else if _phase > 1 {
            _phase = 1
        }

        if _onPhase.count > 0 {
            let phase = self.phase
            for handler in _onPhase {
                handler(phase: phase)
            }
        }

        if _onValue.count > 0 {
            let value = self.value
            for handler in _onValue {
                handler(value: value)
            }
        }
    }

}
