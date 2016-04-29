//
//  NextOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/28/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct NextOperation: OperationValue {
    var minChildNodes: Int? { return 0 }
    var maxChildNodes: Int? { return 0 }
    var description: String = "→"
}
