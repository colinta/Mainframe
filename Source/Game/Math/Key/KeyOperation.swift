////
/// KeyOperation.swift
//

enum KeyCode {
    case delete
    case clear
    case num1
    case num2
    case num3
    case num4
    case num5
    case num6
    case num7
    case num8
    case num9
    case num0
    case dot
    case sign

    case numerator
    case denominator

    // case feet
    // case inches
    // case centimeters
    // case millimeters

    var string: String {
        switch self {
        case .num1: return "1"
        case .num2: return "2"
        case .num3: return "3"
        case .num4: return "4"
        case .num5: return "5"
        case .num6: return "6"
        case .num7: return "7"
        case .num8: return "8"
        case .num9: return "9"
        case .num0: return "0"
        case .dot: return "."
        default: return ""
        }
    }
}

struct KeyOperation: OperationValue {
   var minChildNodes: Int? { return 0 }
   var maxChildNodes: Int? { return 0 }
   var description: String

   init(op: KeyCode) {
       switch op {
       case .delete: description = "⌫"
       case .clear:  description = "C"
       case .num1:   description = "1"
       case .num2:   description = "2"
       case .num3:   description = "3"
       case .num4:   description = "4"
       case .num5:   description = "5"
       case .num6:   description = "6"
       case .num7:   description = "7"
       case .num8:   description = "8"
       case .num9:   description = "9"
       case .num0:   description = "0"
       case .dot:    description = "."
       case .sign:   description = "+/-"
       case .numerator:   description = "◤"
       case .denominator:   description = "◢"
       // case .feet:   description = "ft"
       // case .inches:   description = "in"
       // case .centimeters:   description = "cm"
       // case .millimeters:   description = "mm"
       }
   }
}
