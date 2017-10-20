////
/// TouchSession.swift
//

private let MinDraggingDistance: CGFloat = 4
private let MaxTappedDuration: CGFloat = 0.375

class TouchSession {
    var touch: UITouch
    var isDragging: Bool
    var currentLocation: CGPoint
    var startingLocation: CGPoint
    var startTime: CGFloat
    init(touch: UITouch, location: CGPoint) {
        self.touch = touch
        self.isDragging = false
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
