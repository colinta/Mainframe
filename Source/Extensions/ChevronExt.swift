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

func << <EC1 : RangeReplaceableCollectionType, EC2 : Any where EC1.Generator.Element == EC2>(inout lhs: EC1, rhs: EC2) -> EC1 {
    lhs.append(rhs)
    return lhs
}
