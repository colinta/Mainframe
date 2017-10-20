////
/// CGPoint.swift
//

extension CGPoint {

    init(_ loc: CGFloat) {
        x = loc
        y = loc
    }

    init(_ x: CGFloat, _ y: CGFloat) {
        self.x = x
        self.y = y
    }

    init(x: CGFloat) {
        self.x = x
        y = 0
    }

    init(y: CGFloat) {
        x = 0
        self.y = y
    }

    init(r: CGFloat, a: CGFloat) {
        x = r * cos(a)
        y = r * sin(a)
    }

    var length: CGFloat {
        return CGFloat(sqrt(pow(self.x, 2) + pow(self.y, 2)))
    }

    var angle: CGFloat {
        return CGFloat(atan2(self.y, self.x))
    }

    var roughLength: CGFloat {
        return CGFloat(pow(self.x, 2) + pow(self.y, 2))
    }

    func roughDistanceTo(_ other: CGPoint) -> CGFloat {
        return CGFloat(pow(other.x - self.x, 2) + pow(other.y - self.y, 2))
    }

    func distanceTo(_ other: CGPoint) -> CGFloat {
        return CGFloat(sqrt(roughDistanceTo(other)))
    }

    func distanceTo(_ other: CGPoint, within radius: CGFloat) -> Bool {
        return roughDistanceTo(other) <= pow(radius, 2)
    }

    func lengthWithin(_ radius: CGFloat) -> Bool {
        return roughLength <= pow(radius, 2)
    }

    func angleTo(_ point: CGPoint) -> CGFloat {
        return CGFloat(atan2(point.y - self.y, point.x - self.x))
    }

    func angleTo(_ point: CGPoint, around center: CGPoint) -> CGFloat {
        return CGFloat(atan2(point.y - center.y, point.x - center.x) - atan2(self.y - center.y, self.x - center.x))
    }

    func rectWithSize(_ size: CGSize) -> CGRect {
        return CGRect(x: x - size.width / 2, y: y - size.height / 2, width: size.width, height: size.height)
    }


    // calculates a position between self and the target
    func pointTowards(_ target: CGPoint, speed: CGFloat, dt: CGFloat, radius: CGFloat? = nil) -> CGPoint? {
        guard speed > 0 else {
            return pointTowards(target, speed: -speed, dt: dt, radius: radius)
        }

        let roughDistance = roughDistanceTo(target)
        guard roughDistance > 0.00001 else {
            return nil
        }

        if let radius = radius, roughDistance < pow(radius, 2) {
            return nil
        }

        let angle = atan2(target.y - self.y, target.x - self.x)
        var dist = speed * dt

        // if we are moving a decent amount, more than half a pixel, check to make
        // sure we don't overshoot the target
        if dist > 0.5 {
            let totalDistance = sqrt(roughDistance)
            if dist > totalDistance {
                dist = totalDistance
            }
        }

        guard dist > 0.00001 else {
            return nil
        }
        return self + CGPoint(r: dist, a: angle)
    }

    static func average(_ locations: [CGPoint]) -> CGPoint {
        var retVal: CGPoint = .zero
        for location in locations {
            retVal.x += location.x / CGFloat(locations.count)
            retVal.y += location.y / CGFloat(locations.count)
        }
        return retVal
    }
}

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(
        x: lhs.x + rhs.x,
        y: lhs.y + rhs.y
    )
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(
        x: lhs.x - rhs.x,
        y: lhs.y - rhs.y
    )
}

func +(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(
        x: lhs.x + rhs.width,
        y: lhs.y + rhs.height
    )
}

func -(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(
        x: lhs.x - rhs.width,
        y: lhs.y - rhs.height
    )
}

func +=(lhs: inout CGPoint, rhs: CGPoint) {
    lhs.x += rhs.x
    lhs.y += rhs.y
}

func -=(lhs: inout CGPoint, rhs: CGPoint) {
    lhs.x -= rhs.x
    lhs.y -= rhs.y
}

func *=(lhs: inout CGPoint, scale: CGFloat) {
    lhs.x = lhs.x * scale
    lhs.y = lhs.y * scale
}

func *(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
}
func *(lhs: CGPoint, rhs: CGVector) -> CGPoint {
    return CGPoint(x: lhs.x * rhs.dx, y: lhs.y * rhs.dy)
}

func *(lhs: CGFloat, rhs: CGPoint) -> CGPoint { return rhs * lhs }
func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(
        x: lhs.x * rhs,
        y: lhs.y * rhs
    )
}

func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(
        x: lhs.x / rhs,
        y: lhs.y / rhs
    )
}
