////
/// LetterAndFont.swift
//

struct Letter: Equatable {
    enum Style {
        case Loop
        case Line
        case Fill
    }

    let style: Style
    let size: CGSize
    let points: [[CGPoint]]
}

func ==(lhs: Letter, rhs: Letter) -> Bool {
    if lhs.style == rhs.style && lhs.size == rhs.size && lhs.points.count == rhs.points.count {
        for (index, point) in lhs.points.enumerated() {
            if rhs.points[index] != point {
                return false
            }
        }
        return true
    }
    return false
}

struct Font {
    var stroke: CGFloat
    var scale: CGFloat
    var space: CGFloat
    var art: [String: Letter]
}
