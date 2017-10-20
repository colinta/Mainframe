//
//  WorldScene.swift
//  Mainframe
//
//  Created by Colin Gray on 12/21/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
//

class WorldScene: SKScene {
    var world: World
    var prevTime: TimeInterval?
    var touchSession: TouchSession?

    required init(size: CGSize, world: World) {
        self.world = world
        world.size = size
        world.screenSize = size
        super.init(size: size)
        anchorPoint = CGPoint(0.5, 0.5)

        self << world
    }

    required init?(coder: NSCoder) {
        world = World()
        super.init(coder: coder)
    }

    override func update(_ currentTime: TimeInterval) {
        if let prevTime = prevTime {
            let dt = CGFloat(currentTime - prevTime)
            world.updateWorld(dt)
        }
        prevTime = currentTime
    }

}

extension WorldScene {
    func gameShook() {
        world.worldShook()
    }

    override func touchesBegan(_ touchesSet: Set<UITouch>, with event: UIEvent?) {
        guard touchSession == nil else {
            return
        }

        if let touch = touchesSet.first {
            let worldLocation = touch.location(in: world)
            let touchSession = TouchSession(
                touch: touch,
                location: worldLocation
            )
            self.touchSession = touchSession

            world.worldTouchBegan(touchSession.startingLocation)
        }
    }

    override func touchesMoved(_ touchesSet: Set<UITouch>, with event: UIEvent?) {
        if let touchSession = touchSession, touchesSet.contains(touchSession.touch)
        {
            let worldLocation = touchSession.touch.location(in: world)
            touchSession.currentLocation = worldLocation

            if touchSession.isDragging {
                world.worldDraggingMoved(touchSession.currentLocation)
            }
            else if touchSession.startedDragging {
                world.worldDraggingBegan(touchSession.startingLocation)

                touchSession.isDragging = true
                world.worldDraggingMoved(touchSession.currentLocation)
            }
        }
    }

    override func touchesEnded(_ touchesSet: Set<UITouch>, with event: UIEvent?) {
        if let touchSession = touchSession, touchesSet.contains(touchSession.touch)
        {
            if touchSession.isDragging {
                world.worldDraggingEnded(touchSession.currentLocation)
            }
            else {
                if touchSession.isTap {
                    world.worldTapped(touchSession.currentLocation)
                }
                world.worldPressed(touchSession.currentLocation)
            }

            world.worldTouchEnded(touchSession.currentLocation)

            self.touchSession = nil
        }
    }

    override func touchesCancelled(_ touchesSet: Set<UITouch>?, with event: UIEvent?) {
        if let touchSession = touchSession, let touchesSet = touchesSet,
            touchesSet.contains(touchSession.touch)
        {
            if touchSession.isDragging {
                world.worldDraggingEnded(touchSession.currentLocation)
            }

            world.worldTouchEnded(touchSession.currentLocation)
        }
        touchSession = nil
    }

}
