//
//  ChevronExt.swift
//  Mainframe
//
//  Created by Colin Gray on 7/16/2015.
//  Copyright (c) 2015 Mainframe. All rights reserved.
//

func <<(lhs: UIView, rhs: UIView) {
    lhs.addSubview(rhs)
}

func <<(lhs: UIViewController, rhs: UIViewController) {
    lhs.addChildViewController(rhs)
}

func <<(lhs: SKNode, rhs: SKNode) {
    lhs.addChild(rhs)
}

func << <V>(lhs: inout Array<V>, rhs: V) {
    lhs.append(rhs)
}
