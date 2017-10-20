//
//  JiggleComponent.swift
//  Mainframe
//
//  Created by Colin Gray on 4/28/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

class JiggleComponent: ApplyToNodeComponent {
    var startPosition: CGPoint?
    var timeout: CGFloat?
    var initialTimeout: CGFloat? {
        didSet { timeout = initialTimeout }
    }

    convenience init(timeout: CGFloat?) {
        self.init()
        self.timeout = timeout
        self.initialTimeout = timeout
    }

    required override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func encode(with encoder: NSCoder) {
        super.encode(with: encoder)
    }

    override func reset() {
        super.reset()
    }

    func resetTimeout() {
        self.timeout = initialTimeout
    }

    override func didAddToNode() {
        super.didAddToNode()
        startPosition = node.position
    }

    override func update(_ dt: CGFloat) {
        if let startPosition = startPosition {
            if var timeout = timeout {
                timeout = timeout - dt
                guard timeout > 0 else {
                    apply { applyTo in
                        applyTo.position = startPosition
                    }
                    removeFromNode()
                    return
                }
                self.timeout = timeout
            }

            apply { applyTo in
                applyTo.zRotation += ±rand(min: 0, max: 1.degrees)
                applyTo.position = startPosition + CGPoint(r: rand(min: 0, max: 1), a: rand(TAU))
            }
        }
    }

}
