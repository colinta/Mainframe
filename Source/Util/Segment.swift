////
/// Segment.swift
//

struct Segment {
    var p1: CGPoint
    var p2: CGPoint

    var length: CGFloat { return p1.distanceTo(p2) }

    func intersection(_ segment: Segment) -> CGPoint? {
        let (x1, y1) = (p1.x, p1.y)
        let (x2, y2) = (p2.x, p2.y)
        let (x3, y3) = (segment.p1.x, segment.p1.y)
        let (x4, y4) = (segment.p2.x, segment.p2.y)

        let bottom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
        if bottom == 0 { return nil }

        let x = ((x1*y2 - y1*x2) * (x3 - x4) - (x1 - x2) * (x3*y4 - y3*x4)) / bottom
        let y = ((x1*y2 - y1*x2) * (y3 - y4) - (y1 - y2) * (x3*y4 - y3*x4)) / bottom
        return CGPoint(x, y)
    }

    func intersects(_ segment: Segment) -> Bool {
        let p1 = self.p1
        let q1 = self.p2
        let p2 = segment.p1
        let q2 = segment.p2

        // Find the four orientations needed for general and
        // special cases
        let o1 = orientation(p: p1, q: q1, r: p2)
        let o2 = orientation(p: p1, q: q1, r: q2)
        let o3 = orientation(p: p2, q: q2, r: p1)
        let o4 = orientation(p: p2, q: q2, r: q1)

        // General case
        if o1 != o2 && o3 != o4 {
            return true
        }

        // Special Cases
        // p1, q1 and p2 are colinear and p2 lies on segment p1q1
        if o1 == .Colinear && onSegment(p: p1, q: p2, r: q1) {
            return true
        }

        // p1, q1 and p2 are colinear and q2 lies on segment p1q1
        if o2 == .Colinear && onSegment(p: p1, q: q2, r: q1) {
            return true
        }

        // p2, q2 and p1 are colinear and p1 lies on segment p2q2
        if o3 == .Colinear && onSegment(p: p2, q: p1, r: q2) {
            return true
        }

         // p2, q2 and q1 are colinear and q1 lies on segment p2q2
        if o4 == .Colinear && onSegment(p: p2, q: q1, r: q2) {
            return true
        }

        return false // Doesn't fall in any of the above cases
    }

    private func onSegment(p: CGPoint, q: CGPoint, r: CGPoint) -> Bool {
        if q.x <= max(p.x, r.x) && q.x >= min(p.x, r.x) &&
            q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y) {
           return true
       }

        return false
    }

    enum Orientation {
        case Colinear
        case Clockwise
        case CounterClockwise
    }

    // 0 --> p, q and r are colinear
    // 1 --> Clockwise
    // 2 --> Counterclockwise
    private func orientation(p: CGPoint, q: CGPoint, r: CGPoint) -> Orientation {
        let dy1 = q.y - p.y
        let dx1 = r.x - q.x
        let dx2 = q.x - p.x
        let dy2 = r.y - q.y
        let val = round(dy1 * dx1 - dx2 * dy2)

        if val == 0 {
            return .Colinear  // colinear
        }

        return (val > 0) ? .Clockwise : .CounterClockwise // clock or counterclock wise
    }
}
