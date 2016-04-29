//
//  ImageIdentifier.swift
//  Mainframe
//
//  Created by Colin Gray on 10/19/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
//

enum ImageIdentifier {
    case None
    case ColorPath(path: UIBezierPath, color: Int)
    case ColorLine(length: CGFloat, color: Int)
    case Letter(String, color: Int)
    case Button(style: ButtonStyle, color: Int)
    case Dot(color: Int)
    case FillColorBox(size: CGSize, color: Int)
    case FillColorCircle(size: CGSize, color: Int)
}
