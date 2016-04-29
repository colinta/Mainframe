//
//  Rand.swift
//  Mainframe
//
//  Created by Colin Gray on 4/28/2016.
//  Copyright (c) 2016 Mainframe. All rights reserved.
//

func rand() -> Bool {
    return arc4random_uniform(2) == 1
}

func rand(limit: Int) -> CGFloat {
    return CGFloat(drand48() * Double(limit))
}

func rand(limit: Float) -> CGFloat {
    return CGFloat(drand48() * Double(limit))
}

func rand(limit: Double) -> CGFloat {
    return CGFloat(drand48() * limit)
}

func rand(limit: CGFloat) -> CGFloat {
    return CGFloat(drand48() * Double(limit))
}

func rand(limit: Int) -> Int {
    return Int(arc4random_uniform(UInt32(limit)))
}

func rand(limit: Float) -> Int {
    return Int(drand48() * Double(limit))
}

func rand(limit: Double) -> Int {
    return Int(drand48() * limit)
}

func rand(limit: CGFloat) -> Int {
    return Int(drand48() * Double(limit))
}

func rand(range: Range<Int>) -> CGFloat {
    let min = range.startIndex
    let max = range.endIndex - 1
    return rand(min: min, max: max)
}

func rand(min min: Int, max: Int) -> CGFloat {
    return CGFloat(Double(min) + drand48() * Double(max - min))
}

func rand(min min: Float, max: Float) -> CGFloat {
    return CGFloat(Double(min) + drand48() * Double(max - min))
}

func rand(min min: Double, max: Double) -> CGFloat {
    return CGFloat(Double(min) + drand48() * (max - min))
}

func rand(min min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(Double(min) + drand48() * Double(max - min))
}

func rand(range: Range<Int>) -> Int {
    let min = range.startIndex
    let max = range.endIndex - 1
    return min + Int(arc4random_uniform(UInt32(max - min)))
}

infix operator ± {
    associativity left
    precedence 140
}

prefix operator ± {}

prefix func ±(lhs: CGFloat) -> CGFloat {
    if rand() {
        return lhs
    }
    else {
        return -lhs
    }
}

func ±(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
    if rand() {
        return lhs + rhs
    }
    else {
        return lhs - rhs
    }
}
