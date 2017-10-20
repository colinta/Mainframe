////
/// MoveToComponent.swift
//

class MoveToComponent: ApplyToNodeComponent {
    var target: CGPoint? {
        didSet {
            if _duration != nil && target != nil {
                _speed = nil
            }
        }
    }

    private var _speed: CGFloat? = 100
    var speed: CGFloat? {
        get { return _speed }
        set {
            _speed = newValue
        }
    }
    private var _duration: CGFloat?
    var duration: CGFloat? {
        get { return _duration }
        set {
            _duration = newValue
            _speed = nil
        }
    }

    private var currentPosition: CGPoint { return node.position }

    typealias OnArrived = () -> Void
    private var _onArrived: [OnArrived] = []
    func onArrived(_ handler: @escaping OnArrived) {
        _onArrived.append(handler)
    }

    func removeComponentOnArrived() {
        self.onArrived(removeFromNode)
    }

    func removeNodeOnArrived() {
        self.onArrived {
            guard let node = self.node else { return }
            node.removeFromParent()
        }
    }

    func resetOnArrived() {
        self.onArrived {
            self._onArrived = []
        }
    }

    override func reset() {
        super.reset()
        _onArrived = []
    }

    override func update(_ dt: CGFloat) {
        guard let target = target else { return }

        let speed: CGFloat
        if let _speed = _speed {
            speed = _speed
        }
        else if let duration = _duration {
            speed = max(0.1, (target - currentPosition).length / duration)
            _speed = speed
        }
        else {
            return
        }

        if currentPosition.distanceTo(target, within: dt * speed) {
            apply { applyTo in
                applyTo.position = target
            }

            for handler in _onArrived {
                handler()
            }
            self.target = nil
        }
        else {
            let destAngle = currentPosition.angleTo(target)
            let vector = CGPoint(r: speed, a: destAngle)
            let newPosition = currentPosition + dt * vector

            apply { applyTo in
                applyTo.position = newPosition
            }
        }
    }
}


extension Node {

    @discardableResult
    func moveTo(
        _ dest: CGPoint,
        start: CGPoint? = nil,
        duration: CGFloat? = nil,
        speed: CGFloat? = nil
        ) -> MoveToComponent
    {
        let moveTo = moveToComponent ?? MoveToComponent()
        if let start = start {
            self.position = start
        }
        moveTo.target = dest
        moveTo.duration = duration
        moveTo.speed = speed
        moveTo.removeComponentOnArrived()
        if moveToComponent == nil {
            addComponent(moveTo)
        }

        if duration == nil && speed == nil {
            self.position = dest
        }

        return moveTo
    }
}
