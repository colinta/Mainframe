////
/// TouchableComponent.swift
//

class TouchableComponent: Component {
    enum TouchEvent {
        // a quick tap, no dragging
        case tapped
        case tappedInside
        case tappedOutside
        // any length press, no dragging
        case pressed
        case pressedInside
        case pressedOutside
        // drag events
        case dragBegan
        case dragMoved
        case dragEnded
        // generic down/up/move
        case down
        case downInside
        case downOutside
        case up
        case upInside
        case upOutside
        case moved
        case movedInside
        case movedOutside
        // useful for highlight effects
        case enter
        case exit
    }

    enum TouchTestShape {
        case rect
        case circle

        var touchTest: TouchTest {
            switch self {
            case .rect:
                return { (node, location) in
                    let width = max(44, node.size.width)
                    let height = max(44, node.size.height)
                    if abs(location.x) <= width / 2 && abs(location.y) <= height / 2 {
                        return true
                    }
                    return false
                }
            case .circle:
                return { (node, location) in
                    let width = max(44, node.size.width) / 2
                    let height = max(44, node.size.height) / 2
                    return location.lengthWithin(min(width, height))
                }
            }
        }
    }

    typealias OnTouchEvent = (CGPoint) -> Void
    typealias OnDragged = (CGPoint, CGPoint) -> Void
    typealias TouchTest = (Node, CGPoint) -> Bool

    var isIgnoring = false
    var isTouching = false
    var isTouchingInside = false
    var touchedFor: CGFloat = 0
    var prevLocation: CGPoint?
    var touchEvents = [TouchEvent: [OnTouchEvent]]()
    var _onDragged: [OnDragged] = []
    var containsTouchTest: TouchTest?
    var shouldAcceptTouchTest: TouchTest?

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        super.init()
    }

    override func encode(with encoder: NSCoder) {
        super.encode(with: encoder)
    }

    override func reset() {
        super.reset()
        touchEvents = [:]
        _onDragged = []
    }

    override func update(_ dt: CGFloat) {
        if isTouching {
            self.touchedFor = touchedFor + dt
        }
    }
}

extension TouchableComponent {

    func tapped(_ location: CGPoint) {
        guard !isIgnoring else { return }

        trigger(.tapped, location: location)
        if isTouchingInside {
            trigger(.tappedInside, location: location)
        }
        else {
            trigger(.tappedOutside, location: location)
        }
    }

    func pressed(_ location: CGPoint) {
        guard !isIgnoring else { return }

        trigger(.pressed, location: location)
        if isTouchingInside {
            trigger(.pressedInside, location: location)
        }
        else {
            trigger(.pressedOutside, location: location)
        }
    }

    func touchBegan(_ location: CGPoint) {
        isIgnoring = !self.isEnabled
        guard !isIgnoring else { return }

        isTouchingInside = false
        isTouching = true
        touchedFor = 0

        trigger(.down, location: location)
        trigger(.moved, location: location)

        touchUpdateInOut(location)
        if isTouchingInside {
            trigger(.downInside, location: location)
            trigger(.movedInside, location: location)
        }
        else {
            trigger(.downOutside, location: location)
            trigger(.movedOutside, location: location)
        }

        prevLocation = location
    }

    func touchEnded(_ location: CGPoint) {
        if !isIgnoring {
            if isTouchingInside {
                trigger(.exit, location: location)
                trigger(.upInside, location: location)
            }
            else {
                trigger(.upOutside, location: location)
            }
            trigger(.up, location: location)
        }

        touchedFor = 0
        isIgnoring = false
        isTouching = false
        isTouchingInside = false
        prevLocation = nil
    }

    func touchUpdateInOut(_ location: CGPoint) {
        let isInsideNow = containsTouch(at: location)
        if !isTouchingInside && isInsideNow {
            isTouchingInside = true
            trigger(.enter, location: location)
        }
        else if isTouchingInside && !isInsideNow {
            isTouchingInside = false
            trigger(.exit, location: location)
        }
    }

    func draggingBegan(_ location: CGPoint) {
        guard !isIgnoring else { return }

        trigger(.dragBegan, location: location)
        touchUpdateInOut(location)

        prevLocation = location
    }

    func draggingMoved(_ location: CGPoint) {
        guard !isIgnoring else { return }

        trigger(.moved, location: location)
        trigger(.dragMoved, location: location)

        if let prevLocation = prevLocation {
            for handler in _onDragged {
                handler(prevLocation, location)
            }
        }

        touchUpdateInOut(location)
        if isTouchingInside {
            trigger(.movedInside, location: location)
        }
        else {
            trigger(.movedOutside, location: location)
        }

        prevLocation = location
    }

    func draggingEnded(_ location: CGPoint) {
        guard !isIgnoring else { return }
        trigger(.dragEnded, location: location)
    }

}

extension TouchableComponent {

    func onDragged(_ handler: @escaping OnDragged) {
        _onDragged.append(handler)
    }
    func offDragged() {
        _onDragged = []
    }

    func off(_ events: TouchEvent...) {
        for event in events {
            touchEvents[event] = nil
        }
    }

    func on(_ event: TouchEvent, _ handler: @escaping OnTouchEvent) {
        if touchEvents[event] == nil {
            touchEvents[event] = [handler]
        }
        else {
            touchEvents[event]! << handler
        }
    }

    func trigger(_ event: TouchEvent, location: CGPoint) {
        if let handlers = touchEvents[event] {
            for handler in handlers {
                handler(location)
            }
        }
    }

}

extension TouchableComponent {

    class func defaultTouchTest(shape: TouchTestShape = .rect) -> TouchTest {
        return shape.touchTest
    }


    func shouldAcceptTouch(at location: CGPoint) -> Bool {
        return shouldAcceptTouchTest?(node, location) ?? true
    }

    func containsTouch(at location: CGPoint) -> Bool {
        guard isEnabled else { return false }
        return containsTouchTest?(node, location) ?? false
    }

}
