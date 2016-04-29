//
//  TouchSession.swift
//  Mainframe
//
//  Created by Colin Gray on 12/22/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
//

private let MinDraggingDistance: CGFloat = 4
private let MaxTappedDuration: CGFloat = 0.375

class TouchSession {
    var touch: UITouch
    var dragging: Bool
    var currentLocation: CGPoint
    var startingLocation: CGPoint
    var startTime: CGFloat
    init(touch: UITouch, location: CGPoint) {
        self.touch = touch
        self.dragging = false
        self.currentLocation = location
        self.startingLocation = location
        self.startTime = CGFloat(CACurrentMediaTime())
    }

    var duration: CGFloat { return CGFloat(CACurrentMediaTime()) - startTime }
    var isTap: Bool { return duration < MaxTappedDuration }
    var startedDragging: Bool {
        return !currentLocation.distanceTo(startingLocation, within: MinDraggingDistance)
    }

}
