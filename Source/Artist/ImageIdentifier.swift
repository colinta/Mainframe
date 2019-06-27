////
/// ImageIdentifier.swift
//

enum ImageIdentifier {
    case none
    case colorPath(path: UIBezierPath, color: Int)
    case colorLine(length: CGFloat, color: Int)
    case letter(String, color: Int)
    case button(style: ButtonStyle, borderColor: Int?)
    case fillColorBox(size: CGSize, color: Int)
    case fillColorCircle(size: CGSize, color: Int)
    case expand
}
