////
///  Sign.swift
//

enum Sign {
    case positive
    case negative

    static prefix func - (_ sign: Sign) -> Sign {
        switch sign {
        case .positive: return .negative
        case .negative: return .positive
        }
    }

    static func * (_ sign: Sign, _ rhs: Decimal) -> Decimal {
        switch sign {
        case .positive: return rhs
        case .negative: return -rhs
        }
    }

    static func * (_ sign: Sign, _ rhs: Int) -> Int {
        switch sign {
        case .positive: return rhs
        case .negative: return -rhs
        }
    }

    static func * (_ sign: Sign, _ rhs: String) -> String {
        switch sign {
        case .positive: return rhs
        case .negative: return "-" + rhs
        }
    }
}
