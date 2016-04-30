//
//  SmallFont.swift
//  FlatoutWar
//
//  Created by Colin Gray on 8/15/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
//

private let defaultSize = CGSize(width: 4, height: 8)
private let smallSize = CGSize(3, defaultSize.height)
let SmallFont = Font(
    stroke: 0.5,
    scale: 3,
    space: 2,
    art: [
    " ": Letter(style: .Line, size: CGSize(width: 3, height: defaultSize.height), points: [[CGPoint]]()),
    ".": Letter(style: .Line, size: CGSize(width: 0.5, height: defaultSize.height), points: [[
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
    ]]),
    ",": Letter(style: .Loop, size: CGSize(width: 0.5, height: defaultSize.height), points: [[
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
        CGPoint(x: 0.25, y: 7),
    ]]),
    "?": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 0, y: 0.5),
        CGPoint(x: 0.5, y: 0),
        CGPoint(x: 2.5, y: 0),
        CGPoint(x: 3, y: 0.5),
        CGPoint(x: 3, y: 1.5),
        CGPoint(x: 1.5, y: 3),
        CGPoint(x: 1.5, y: 5),
    ], [
        CGPoint(x: 1.25, y: 6),
        CGPoint(x: 1.75, y: 6),
    ]]),
    "/": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
    ]]),
    "(": Letter(style: .Line, size: CGSize(width: 1, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: -0.5),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 1, y: 6.5),
    ]]),
    ")": Letter(style: .Line, size: CGSize(width: 1, height: defaultSize.height), points: [[
        CGPoint(x: 0, y: -0.5),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 1, y: 4),
        CGPoint(x: 0, y: 6.5),
    ]]),
    "!": Letter(style: .Line, size: CGSize(width: 0.5, height: defaultSize.height), points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 5),
    ], [
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
    ]]),
    "↓": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 4, y: 4),
    ]]),
    "↑": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 2, y: 6),
        CGPoint(x: 2, y: 0),
    ], [
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 4, y: 2),
    ]]),
    "→": Letter(style: .Line, size: CGSize(width: 6, height: 4), points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 6, y: 2),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 6, y: 2),
        CGPoint(x: 4, y: 4),
    ]]),
    "←": Letter(style: .Line, size: CGSize(width: 6, height: 4), points: [[
        CGPoint(x: 6, y: 2),
        CGPoint(x: 0, y: 2),
    ], [
        CGPoint(x: 2, y: 0),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 4),
    ]]),
    ">": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 6),
    ]]),
    "<": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 6),
    ]]),
    "⌫": Letter(style: .Loop, size: CGSize(5, defaultSize.height), points: [[
        CGPoint(x: 2, y: 1),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 2, y: 5),
        CGPoint(x: 5, y: 5),
        CGPoint(x: 5, y: 1),
    ], [
        CGPoint(x: 2, y: 2),
        CGPoint(x: 4, y: 4),
    ], [
        CGPoint(x: 2, y: 4),
        CGPoint(x: 4, y: 2),
    ]]),
    "=": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 4, y: 4),
    ]]),
    "+": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ], [
        CGPoint(x: 2, y: 1),
        CGPoint(x: 2, y: 5),
    ]]),
    "-": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ]]),
    "÷": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ], [
        CGPoint(x: 1.75, y: 0.75),
        CGPoint(x: 2.25, y: 0.75),
        CGPoint(x: 2.25, y: 1.25),
        CGPoint(x: 1.75, y: 1.25),
    ], [
        CGPoint(x: 1.75, y: 4.75),
        CGPoint(x: 2.25, y: 4.75),
        CGPoint(x: 2.25, y: 5.25),
        CGPoint(x: 1.75, y: 5.25),
    ]]),
    "×": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 1),
        CGPoint(x: 4, y: 5),
    ], [
        CGPoint(x: 4, y: 1),
        CGPoint(x: 0, y: 5),
    ]]),
    "±": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 4),
    ], [
        CGPoint(x: 0.5, y: 6),
        CGPoint(x: 3.5, y: 6),
    ], [
        CGPoint(x: 1.75, y: 5),
        CGPoint(x: 2.25, y: 5),
    ], [
        CGPoint(x: 1.75, y: 7),
        CGPoint(x: 2.25, y: 7),
    ]]),
    "≠": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 3.5, y: 2),
    ], [
        CGPoint(x: 1, y: 5),
        CGPoint(x: 3, y: 7),
    ], [
        CGPoint(x: 3, y: 5),
        CGPoint(x: 1, y: 7),
    ]]),
    "√": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: -0.5, y: 4),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 0),
    ]]),
    "⁰": Letter(style: .Loop, size: CGSize(2, defaultSize.height), points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 0, y: 2),
    ]]),
    "ₒ": Letter(style: .Loop, size: CGSize(2, defaultSize.height), points: [[
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 2, y: 8),
        CGPoint(x: 0, y: 8),
    ]]),
    "◻": Letter(style: .Loop, size: smallSize, points: [[
        CGPoint(x: 0, y: 1.5),
        CGPoint(x: 3, y: 1.5),
        CGPoint(x: 3, y: 4.5),
        CGPoint(x: 0, y: 4.5),
    ]]),
    "◼": Letter(style: .Fill, size: smallSize, points: [[
        CGPoint(x: 0, y: 1.5),
        CGPoint(x: 3, y: 1.5),
        CGPoint(x: 3, y: 4.5),
        CGPoint(x: 0, y: 4.5),
    ]]),
    "0": Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 0, y: 6),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
    ]]),
    "1": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6.25),
    ]]),
    "2": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]]),
    "3": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 0, y: 6),
    ]]),
    "4": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 3, y: 0),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 4, y: 4),
    ], [
        CGPoint(x: 3, y: 1),
        CGPoint(x: 3, y: 6.25),
    ]]),
    "5": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 0, y: 6),
    ]]),
    "6": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 3, y: 3),
    ]]),
    "7": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6.25),
    ]]),
    "8": Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 3),
    ]]),
    "9": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6.25),
    ]]),
    "a": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 3, y: 1.75),
        CGPoint(x: 3, y: 6.25),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0, y: 5.5),
        CGPoint(x: 0.5, y: 6),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 3, y: 5),
    ]]),
    "A": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 6.25),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ]]),
    "b": Letter(style: .Loop, size: smallSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 3, y: 2.75),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 0, y: 2),
    ]]),
    "B": Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 3, y: 1),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 0, y: 6),
    ]]),
    "c": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 0, y: 2.75),
        CGPoint(x: 0, y: 5.25),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 6),
    ]]),
    "C": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 4, y: 6),
    ]]),
    "D": Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 0, y: 6),
    ]]),
    "𝚎": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 3, y: 6),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
    ]]),
    "e": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
        CGPoint(x: 3, y: 2),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 3, y: 6),
    ]]),
    "E": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 3, y: 3),
    ]]),
    "F": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1.5, y: 3),
    ]]),
    "g": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 3, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5.25),
        CGPoint(x: 0, y: 2.75),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 3, y: 2),
        CGPoint(x: 3, y: 8),
        CGPoint(x: 1, y: 8),
        CGPoint(x: 0, y: 7.25),
    ]]),
    "G": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 3, y: 3),
    ]]),
    "H": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6.25),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ], [
        CGPoint(x: 4, y: -0.25),
        CGPoint(x: 4, y: 6.25),
    ]]),
    "i": Letter(style: .Line, size: CGSize(width: 2, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: 1.75),
        CGPoint(x: 1, y: 6.25),
    ], [
        CGPoint(x: 1, y: 0.2),
        CGPoint(x: 1, y: 0.7),
    ]]),
    "I": Letter(style: .Line, size: CGSize(width: 2, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: -0.25),
        CGPoint(x: 1, y: 6.25),
    ]]),
    "J": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: -0.25),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 4),
    ]]),
    "K": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6.25),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 6),
    ]]),
    "l": Letter(style: .Line, size: CGSize(2, defaultSize.height), points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 1, y: 6),
    ]]),
    "L": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]]),
    "M": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6.25),
    ]]),
    "n": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 0, y: 1.75),
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2.5, y: 2),
        CGPoint(x: 3, y: 2.5),
        CGPoint(x: 3, y: 6.25),
    ]]),
    "N": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: -0.25),
    ]]),
    "o": Letter(style: .Loop, size: smallSize, points: [[
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 3, y: 2.75),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5.25),
        CGPoint(x: 0, y: 2.75),
    ]]),
    "O": Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 1, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 1),
    ]]),
    "P": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0, y: 3),
    ]]),
    "Q": Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 1, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 1),
    ], [
        CGPoint(x: 2, y: 4),
        CGPoint(x: 3, y: 6),
    ]]),
    "r": Letter(style: .Line, size: CGSize(1.75, defaultSize.height), points: [[
        CGPoint(x: 0, y: 1.75),
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2, y: 2),
    ]]),
    "R": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0.5, y: 3),
        CGPoint(x: 4, y: 6.25),
    ]]),
    "s": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 0, y: 2.75),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 0, y: 6),
    ]]),
    "S": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 0, y: 6),
    ]]),
    "t": Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 3, y: 2),
    ], [
        CGPoint(x: 1.5, y: 1),
        CGPoint(x: 1.5, y: 6.25),
    ]]),
    "T": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6.25),
    ]]),
    "U": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 4, y: -0.25),
    ]]),
    "V": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 4, y: 0),
    ]]),
    "W": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 0),
    ]]),
    "X": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 6),
    ], [
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 0),
    ]]),
    "Y": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 2, y: 3),
        CGPoint(x: 2, y: 6.25),
    ]]),
    "Z": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]]),
    "π": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 1, y: 2),
        CGPoint(x: 1, y: 6),
    ], [
        CGPoint(x: 3, y: 2),
        CGPoint(x: 3, y: 6),
    ]]),
    "τ": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 2, y: 2),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 3, y: 6),
    ]]),
    "𝑒": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3.5, y: 4),
        CGPoint(x: 4, y: 3.5),
        CGPoint(x: 4, y: 2.5),
        CGPoint(x: 3.5, y: 2),
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0, y: 5.5),
        CGPoint(x: 0.5, y: 6),
        CGPoint(x: 3.5, y: 6),
        CGPoint(x: 4, y: 5.5),
    ]]),
    "𝑓": Letter(style: .Line, size: CGSize(width: 3, height: defaultSize.height), points: [[
        CGPoint(x: 3, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 6),
    ], [
        CGPoint(x: 0.5, y: 3),
        CGPoint(x: 2.5, y: 3),
    ]]),
    "𝑥": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 3.5, y: 6),
        CGPoint(x: 4, y: 5.5),
    ], [
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 4, y: 1.75),
    ]]),
    "𝑦": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 4.25, y: 2.25),
    ], [
        CGPoint(x: 2, y: 6),
        CGPoint(x: 1, y: 8),
        CGPoint(x: 0, y: 8),
    ]]),
    "𝑧": Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 5.5),
    ]]),
])
