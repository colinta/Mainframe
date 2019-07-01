////
///  OutputStyle.swift
//

enum OutputStyle {
    case exact
    case number
    case woodworking

    var next: OutputStyle {
        switch self {
        case .exact:
            return .number
        case .number:
            return .woodworking
        case .woodworking:
            return .exact
        }
    }
}
