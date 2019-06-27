////
/// Artist.swift
//

private var generatedImages = [String: UIImage]()

class Artist {
    enum Scale {
        case small
        case normal

        var scale: CGFloat {
            switch self {
            case .small: return 1
            case .normal: return 2
            }
        }

        var name: String { return "\(self)" }
    }

    var center: CGPoint = .zero
    private(set) var middle: CGPoint = .zero
    var size: CGSize = .zero {
        didSet {
            middle = CGPoint(x: size.width / 2, y: size.height / 2)
        }
    }
    var scale: CGFloat = 1
    var rotation: CGFloat = 0
    var alpha: CGFloat = 1

    required init() {
    }

    func drawIn(context: CGContext, scale: Scale) {
        context.saveGState()
        context.scaleBy(x: self.scale, y: self.scale)
        context.setAlpha(alpha)

        let offset = drawingOffset(scale: scale)
        context.translateBy(x: offset.x, y: offset.y)

        if rotation != 0 {
            context.translateBy(x: size.width / 2, y: size.height / 2)
            context.rotate(by: rotation)
            context.translateBy(x: -size.width / 2, y: -size.height / 2)
        }
        draw(context: context, scale: scale)
        context.restoreGState()
    }

    func draw(context: CGContext, scale: Scale) {
        draw(context: context)
    }

    func draw(context: CGContext) {
    }

    func drawingOffset(scale: Scale) -> CGPoint {
        return CGPoint(1)
    }

    func imageSize(scale: Scale) -> CGSize {
        var size = self.size
        let offset = drawingOffset(scale: scale)
        size += CGSize(
            width: offset.x * 2,
            height: offset.y * 2
        )
        size.width = max(size.width, 1)
        size.height = max(size.height, 1)
        return size
    }
}

extension Artist {
    class func generate(id: ImageIdentifier, scale: Scale = .normal) -> UIImage {
        let artist = id.artist
        artist.scale = scale.scale
        let size = artist.imageSize(scale: scale) * artist.scale

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        artist.drawIn(context: context, scale: scale)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
