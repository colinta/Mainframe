//
//  CloseButton.swift
//  FlatoutWar
//
//  Created by Colin Gray on 1/9/2016.
//  Copyright (c) 2016 FlatoutWar. All rights reserved.
//

class CloseButton: Button {

    required init() {
        super.init()
        setScale(0.5)
        text = "×"
        size = CGSize(60)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
