//
//  DotArtist.swift
//  FlatoutWar
//
//  Created by Colin Gray on 4/10/2016.
//  Copyright (c) 2016 FlatoutWar. All rights reserved.
//

class DotArtist: Artist {
    var color: UIColor = .white

    required init() {
        super.init()
        size = CGSize(2)
    }

    override func draw(context: CGContext) {
        context.setFillColor(color.cgColor)
        context.addEllipse(in: CGRect(origin: .zero, size: size))
        context.drawPath(using: .fill)
    }

}
