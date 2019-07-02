////
///  OutputStyle.swift
//

enum OutputStyle {
    case exact
    case number

    var next: OutputStyle {
        switch self {
        case .exact:
            return .number
        case .number:
            return .exact
        }
    }
}
