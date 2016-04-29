//
//  KeyOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/24/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct KeyOperation: OperationValue {
    var minChildNodes: Int? { return 0 }
    var maxChildNodes: Int? { return 0 }
    var description: String

    init(op: Operation) {
        switch op {
        case .Delete:     description = "⌫"
        case .Clear:      description = "C"
        case .Num1:       description = "1"
        case .Num2:       description = "2"
        case .Num3:       description = "3"
        case .Num4:       description = "4"
        case .Num5:       description = "5"
        case .Num6:       description = "6"
        case .Num7:       description = "7"
        case .Num8:       description = "8"
        case .Num9:       description = "9"
        case .Num0:       description = "0"
        case .NumDot:     description = "."
        case .SignSwitch: description = "+/-"
        default:         description = ""
        }
    }
}
