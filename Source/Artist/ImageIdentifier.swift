////
/// ImageIdentifier.swift
//

enum ImageIdentifier {
    case None
    case ColorPath(path: UIBezierPath, color: Int)
    case ColorLine(length: CGFloat, color: Int)
    case Letter(String, color: Int)
    case Button(style: ButtonStyle, color: Int)
    case Dot(color: Int)
    case FillColorBox(size: CGSize, color: Int)
    case FillColorCircle(size: CGSize, color: Int)
}
