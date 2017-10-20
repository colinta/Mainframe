////
/// SmallFont.swift
//

private let defaultSize = CGSize(width: 4, height: 8)
private let smallSize = CGSize(3, defaultSize.height)

let l1 = Letter(style: .Line, size: CGSize(3, defaultSize.height), points: [])
let l2 = Letter(style: .Line, size: CGSize(1, defaultSize.height), points: [])
let l3 = Letter(style: .Loop, size: CGSize(0.5, defaultSize.height), points: [[
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
        CGPoint(x: 0.25, y: 6.25),
        CGPoint(x: -0.25, y: 6.25),
    ]])
let l4 = Letter(style: .Loop, size: CGSize(0.5, defaultSize.height), points: [[
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
        CGPoint(x: 0.25, y: 7),
    ]])
let l5 = Letter(style: .Line, size: smallSize, points: [[
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
    ]])
let l6 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
    ]])
let l7 = Letter(style: .Line, size: CGSize(width: 1, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: -0.5),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 1, y: 6.5),
    ]])
let l8 = Letter(style: .Line, size: CGSize(width: 1, height: defaultSize.height), points: [[
        CGPoint(x: 0, y: -0.5),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 1, y: 4),
        CGPoint(x: 0, y: 6.5),
    ]])
let l9 = Letter(style: .Line, size: CGSize(width: 0.5, height: defaultSize.height), points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 5),
    ], [
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
    ]])
let l10 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 4, y: 4),
    ]])
let l11 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 2, y: 6),
        CGPoint(x: 2, y: 0),
    ], [
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 4, y: 2),
    ]])
let l12 = Letter(style: .Line, size: CGSize(width: 6, height: 4), points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 6, y: 2),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 6, y: 2),
        CGPoint(x: 4, y: 4),
    ]])
let l13 = Letter(style: .Line, size: CGSize(width: 6, height: 4), points: [[
        CGPoint(x: 6, y: 2),
        CGPoint(x: 0, y: 2),
    ], [
        CGPoint(x: 2, y: 0),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 4),
    ]])
let l14 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 6),
    ]])
let l15 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 6),
    ]])
let l16 = Letter(style: .Loop, size: CGSize(5, defaultSize.height), points: [[
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
    ]])
let l17 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 4, y: 4),
    ]])
let l18 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ], [
        CGPoint(x: 2, y: 1),
        CGPoint(x: 2, y: 5),
    ]])
let l19 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ]])
let l20 = Letter(style: .Line, size: defaultSize, points: [[
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
    ]])
let l21 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0.5, y: 1.5),
        CGPoint(x: 3.5, y: 4.5),
    ], [
        CGPoint(x: 3.5, y: 1.5),
        CGPoint(x: 0.5, y: 4.5),
    ]])
let l22 = Letter(style: .Line, size: defaultSize, points: [[
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
    ]])
let l23 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 3.5, y: 2),
    ], [
        CGPoint(x: 1, y: 5),
        CGPoint(x: 3, y: 7),
    ], [
        CGPoint(x: 3, y: 5),
        CGPoint(x: 1, y: 7),
    ]])
let l24 = Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: -0.5, y: 4),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 0),
    ]])
let l25 = Letter(style: .Loop, size: CGSize(2, defaultSize.height), points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 0, y: 2),
    ]])
let l26 = Letter(style: .Loop, size: CGSize(2, defaultSize.height), points: [[
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 2, y: 8),
        CGPoint(x: 0, y: 8),
    ]])
let l27 = Letter(style: .Loop, size: smallSize, points: [[
        CGPoint(x: 0, y: 1.5),
        CGPoint(x: 3, y: 1.5),
        CGPoint(x: 3, y: 4.5),
        CGPoint(x: 0, y: 4.5),
    ]])
let l28 = Letter(style: .Fill, size: smallSize, points: [[
        CGPoint(x: 0, y: 1.5),
        CGPoint(x: 3, y: 1.5),
        CGPoint(x: 3, y: 4.5),
        CGPoint(x: 0, y: 4.5),
    ]])
let l29 = Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 0, y: 6),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
    ]])
let l30 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6.25),
    ]])
let l31 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]])
let l32 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
let l33 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 3, y: 0),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 4, y: 4),
    ], [
        CGPoint(x: 3, y: 1),
        CGPoint(x: 3, y: 6.25),
    ]])
let l34 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
let l35 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 3, y: 3),
    ]])
let l36 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6.25),
    ]])
let l37 = Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 3),
    ]])
let l38 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6.25),
    ]])
let l39 = Letter(style: .Line, size: smallSize, points: [[
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
    ]])
let l40 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 6.25),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ]])
let l41 = Letter(style: .Loop, size: smallSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 3, y: 2.75),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 0, y: 2),
    ]])
let l42 = Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 3, y: 1),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
let l43 = Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 0, y: 2.75),
        CGPoint(x: 0, y: 5.25),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 6),
    ]])
let l44 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 4, y: 6),
    ]])
let l45 = Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
let l46 = Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 3, y: 6),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
    ]])
let l47 = Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
        CGPoint(x: 3, y: 2),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 3, y: 6),
    ]])
let l48 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 3, y: 3),
    ]])
let l49 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1.5, y: 3),
    ]])
let l50 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 3, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5.25),
        CGPoint(x: 0, y: 2.75),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 3, y: 2),
        CGPoint(x: 3, y: 8),
        CGPoint(x: 1, y: 8),
        CGPoint(x: 0, y: 7.25),
    ]])
let l51 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 3, y: 3),
    ]])
let l52 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6.25),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ], [
        CGPoint(x: 4, y: -0.25),
        CGPoint(x: 4, y: 6.25),
    ]])
let l53 = Letter(style: .Line, size: CGSize(width: 2, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: 1.75),
        CGPoint(x: 1, y: 6.25),
    ], [
        CGPoint(x: 1, y: 0.2),
        CGPoint(x: 1, y: 0.7),
    ]])
let l54 = Letter(style: .Line, size: CGSize(width: 2, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: -0.25),
        CGPoint(x: 1, y: 6.25),
    ]])
let l55 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: -0.25),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 4),
    ]])
let l56 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6.25),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 6),
    ]])
let l57 = Letter(style: .Line, size: CGSize(2, defaultSize.height), points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 1, y: 6),
    ]])
let l58 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]])
let l59 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6.25),
    ]])
let l60 = Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 0, y: 1.75),
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2.5, y: 2),
        CGPoint(x: 3, y: 2.5),
        CGPoint(x: 3, y: 6.25),
    ]])
let l61 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: -0.25),
    ]])
let l62 = Letter(style: .Loop, size: smallSize, points: [[
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 3, y: 2.75),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5.25),
        CGPoint(x: 0, y: 2.75),
    ]])
let l63 = Letter(style: .Loop, size: defaultSize, points: [[
        CGPoint(x: 1, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 1),
    ]])
let l64 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0, y: 3),
    ]])
let l65 = Letter(style: .Loop, size: defaultSize, points: [[
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
    ]])
let l66 = Letter(style: .Line, size: CGSize(1.75, defaultSize.height), points: [[
        CGPoint(x: 0, y: 1.75),
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2, y: 2),
    ]])
let l67 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0.5, y: 3),
        CGPoint(x: 4, y: 6.25),
    ]])
let l68 = Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 0, y: 2.75),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
let l69 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
let l70 = Letter(style: .Line, size: smallSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 3, y: 2),
    ], [
        CGPoint(x: 1.5, y: 1),
        CGPoint(x: 1.5, y: 6.25),
    ]])
let l71 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6.25),
    ]])
let l72 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 4, y: -0.25),
    ]])
let l73 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 4, y: 0),
    ]])
let l74 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 0),
    ]])
let l75 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 6),
    ], [
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 0),
    ]])
let l76 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 2, y: 3),
        CGPoint(x: 2, y: 6.25),
    ]])
let l77 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]])
let l78 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 1, y: 2),
        CGPoint(x: 1, y: 6),
    ], [
        CGPoint(x: 3, y: 2),
        CGPoint(x: 3, y: 6),
    ]])
let l79 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 2, y: 2),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 3, y: 6),
    ]])
let l80 = Letter(style: .Line, size: defaultSize, points: [[
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
    ]])
let l81 = Letter(style: .Line, size: CGSize(width: 3, height: defaultSize.height), points: [[
        CGPoint(x: 3, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 6),
    ], [
        CGPoint(x: 0.5, y: 3),
        CGPoint(x: 2.5, y: 3),
    ]])
let l82 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 3.5, y: 6),
        CGPoint(x: 4, y: 5.5),
    ], [
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 4, y: 1.75),
    ]])
let l83 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 4.25, y: 2.25),
    ], [
        CGPoint(x: 2, y: 6),
        CGPoint(x: 1, y: 8),
        CGPoint(x: 0, y: 8),
    ]])
let l84 = Letter(style: .Line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 5.5),
    ]])

let SmallFont = Font(
    stroke: 0.5,
    scale: 3,
    space: 2,
    art: [
    " ": l1,
    "␠": l2,
    ".": l3,
    ",": l4,
    "?": l5,
    "/": l6,
    "(": l7,
    ")": l8,
    "!": l9,
    "↓": l10,
    "↑": l11,
    "→": l12,
    "←": l13,
    ">": l14,
    "<": l15,
    "⌫": l16,
    "=": l17,
    "+": l18,
    "-": l19,
    "÷": l20,
    "×": l21,
    "±": l22,
    "≠": l23,
    "√": l24,
    "⁰": l25,
    "ₒ": l26,
    "◻": l27,
    "◼": l28,
    "0": l29,
    "1": l30,
    "2": l31,
    "3": l32,
    "4": l33,
    "5": l34,
    "6": l35,
    "7": l36,
    "8": l37,
    "9": l38,
    "a": l39,
    "A": l40,
    "b": l41,
    "B": l42,
    "c": l43,
    "C": l44,
    "D": l45,
    "𝚎": l46,
    "e": l47,
    "E": l48,
    "F": l49,
    "g": l50,
    "G": l51,
    "H": l52,
    "i": l53,
    "I": l54,
    "J": l55,
    "K": l56,
    "l": l57,
    "L": l58,
    "M": l59,
    "n": l60,
    "N": l61,
    "o": l62,
    "O": l63,
    "P": l64,
    "Q": l65,
    "r": l66,
    "R": l67,
    "s": l68,
    "S": l69,
    "t": l70,
    "T": l71,
    "U": l72,
    "V": l73,
    "W": l74,
    "X": l75,
    "Y": l76,
    "Z": l77,
    "π": l78,
    "τ": l79,
    "𝑒": l80,
    "𝑓": l81,
    "𝑥": l82,
    "𝑦": l83,
    "𝑧": l84,
])
