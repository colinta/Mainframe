//
//  NoOperation.swift
//  Mainframe
//
//  Created by Colin Gray on 4/23/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

struct NoOperation: OperationValue {
    var description: String { return "" }
    var minChildNodes: Int? = 0
    var maxChildNodes: Int? = 0
}
