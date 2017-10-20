////
/// CGSizeExt.swift
//

extension CGSize {

    init(_ size: CGFloat) {
        width = size
        height = size
    }

    init(r: CGFloat) {
        width = 2 * r
        height = 2 * r
    }

    init(_ width: CGFloat, _ height: CGFloat) {
        self.width = width
        self.height = height
    }

    init(width: CGFloat) {
        self.width = width
        height = 0
    }

    init(height: CGFloat) {
        width = 0
        self.height = height
    }

    var angle: CGFloat {
        return CGFloat(atan2(height, width))
    }

    var length: CGFloat {
        return CGFloat(sqrt(pow(width, 2) + CGFloat(pow(height, 2))))
    }

}


func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(
        width: lhs.width + rhs.width,
        height: lhs.height + rhs.height
    )
}

func +=(lhs: inout CGSize, rhs: CGSize) {
    lhs.width += rhs.width
    lhs.height += rhs.height
}

func -=(lhs: inout CGSize, rhs: CGSize) {
    lhs.width -= rhs.width
    lhs.height -= rhs.height
}

func *=(lhs: inout CGSize, scale: CGFloat) {
    lhs.width = lhs.width * scale
    lhs.height = lhs.height * scale
}

func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(
        width: lhs.width - rhs.width,
        height: lhs.height - rhs.height
    )
}

func *(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize(width: lhs.width * rhs.x, height: lhs.height * rhs.y)
}
func *(lhs: CGSize, rhs: CGVector) -> CGSize {
    return CGSize(width: lhs.width * rhs.dx, height: lhs.height * rhs.dy)
}

func *(lhs: CGSize, rhs: CGFloat) -> CGSize { return rhs * lhs }
func *(lhs: CGFloat, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs * rhs.width, height: lhs * rhs.height)
}

func /(lhs: CGSize, rhs: CGFloat) -> CGSize { return rhs / lhs }
func /(lhs: CGFloat, rhs: CGSize) -> CGSize {
    return CGSize(width: rhs.width / lhs, height: rhs.height / lhs)
}
