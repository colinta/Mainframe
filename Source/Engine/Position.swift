//
//  Position.swift
//  FlatoutWar
//
//  Created by Colin Gray on 1/2/2016.
//  Copyright (c) 2016 FlatoutWar. All rights reserved.
//

enum Position {
    case TopLeft(x: CGFloat, y: CGFloat)
    case Top(x: CGFloat, y: CGFloat)
    case TopRight(x: CGFloat, y: CGFloat)
    case Left(x: CGFloat, y: CGFloat)
    case Center(x: CGFloat, y: CGFloat)
    case Right(x: CGFloat, y: CGFloat)
    case BottomLeft(x: CGFloat, y: CGFloat)
    case Bottom(x: CGFloat, y: CGFloat)
    case BottomRight(x: CGFloat, y: CGFloat)

    func positionIn(screenSize size: CGSize) -> CGPoint {
        let half = size / 2

        switch self {
        case let .TopLeft(x, y):
            return CGPoint(x: -half.width + x, y: half.height + y)
        case let .Top(x, y):
            return CGPoint(x: x, y: half.height + y)
        case let .TopRight(x, y):
            return CGPoint(x: half.width + x, y: half.height + y)
        case let .Left(x, y):
            return CGPoint(x: -half.width + x, y: y)
        case let .Center(x, y):
            return CGPoint(x: x, y: y)
        case let .Right(x, y):
            return CGPoint(x: half.width + x, y: y)
        case let .BottomLeft(x, y):
            return CGPoint(x: -half.width + x, y: -half.height + y)
        case let .Bottom(x, y):
            return CGPoint(x: x, y: -half.height + y)
        case let .BottomRight(x, y):
            return CGPoint(x: half.width + x, y: -half.height + y)
        }
    }

    var x: CGFloat {
        switch self {
        case let .TopLeft(x, _):
            return x
        case let .Top(x, _):
            return x
        case let .TopRight(x, _):
            return x
        case let .Left(x, _):
            return x
        case let .Center(x, _):
            return x
        case let .Right(x, _):
            return x
        case let .BottomLeft(x, _):
            return x
        case let .Bottom(x, _):
            return x
        case let .BottomRight(x, _):
            return x
        }
    }

    var y: CGFloat {
        switch self {
        case let .TopLeft(_, y):
            return y
        case let .Top(_, y):
            return y
        case let .TopRight(_, y):
            return y
        case let .Left(_, y):
            return y
        case let .Center(_, y):
            return y
        case let .Right(_, y):
            return y
        case let .BottomLeft(_, y):
            return y
        case let .Bottom(_, y):
            return y
        case let .BottomRight(_, y):
            return y
        }
    }
}


func +(lhs: Position, rhs: CGPoint) -> Position {
    switch lhs {
    case let .TopLeft(x, y):
        return .TopLeft(x: x + rhs.x, y: y + rhs.y)
    case let .Top(x, y):
        return .Top(x: x + rhs.x, y: y + rhs.y)
    case let .TopRight(x, y):
        return .TopRight(x: x + rhs.x, y: y + rhs.y)
    case let .Left(x, y):
        return .Left(x: x + rhs.x, y: y + rhs.y)
    case let .Center(x, y):
        return .Center(x: x + rhs.x, y: y + rhs.y)
    case let .Right(x, y):
        return .Right(x: x + rhs.x, y: y + rhs.y)
    case let .BottomLeft(x, y):
        return .BottomLeft(x: x + rhs.x, y: y + rhs.y)
    case let .Bottom(x, y):
        return .Bottom(x: x + rhs.x, y: y + rhs.y)
    case let .BottomRight(x, y):
        return .BottomRight(x: x + rhs.x, y: y + rhs.y)
    }
}
