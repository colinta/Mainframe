////
/// NumberExt.swift
//

extension CGFloat {
    var degrees: CGFloat {
        return CGFloat(self) / 360 * TAU
    }

    var pixels: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }
}

extension Double {
    var degrees: CGFloat {
        return CGFloat(self) / 360 * TAU
    }

    var pixels: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }
}


extension Int {
    var degrees: CGFloat {
        return CGFloat(self) / 360 * TAU
    }

    var pixels: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }
}
