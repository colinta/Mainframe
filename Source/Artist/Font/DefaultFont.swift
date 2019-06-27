////
/// DefaultFont.swift
//

private let defaultSize = CGSize(width: 4, height: 8)
private let mediumSize = CGSize(width: 3, height: 8)
private let narrowSize = CGSize(width: 2, height: 8)
private let doubleWidthSize = CGSize(width: 8, height: 8)

// " "
let l0 = Letter(style: .line, size: CGSize(3, defaultSize.height), points: [])
// "␠" inserted in decimal output
let l1 = Letter(style: .line, size: CGSize(1, defaultSize.height), points: [])
// "."
let l2 = Letter(style: .loop, size: CGSize(0.5, defaultSize.height), points: [[
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
        CGPoint(x: 0.25, y: 6.25),
        CGPoint(x: -0.25, y: 6.25),
    ]])
// ","
let l3 = Letter(style: .loop, size: CGSize(0.5, defaultSize.height), points: [[
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
        CGPoint(x: 0.25, y: 7),
    ]])
// "0"
let l4 = Letter(style: .loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 0, y: 6),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
    ]])
// "1"
let l5 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6.25),
    ]])
// "2"
let l6 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]])
// "3"
let l7 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
// "4"
let l8 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 3, y: 0),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 4, y: 4),
    ], [
        CGPoint(x: 3, y: 1),
        CGPoint(x: 3, y: 6.25),
    ]])
// "5"
let l9 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4.5, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 3.5, y: 2.5),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 5.5),
        CGPoint(x: 3.5, y: 6),
        CGPoint(x: 0.5, y: 6),
        CGPoint(x: -0.5, y: 5),
    ]])
// "6"
let l10 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 3, y: 3),
    ]])
// "7"
let l11 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6.25),
    ]])
// "8"
let l12 = Letter(style: .loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 3),
    ]])
// "9"
let l13 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6.25),
    ]])
// "a"
let l14 = Letter(style: .line, size: mediumSize, points: [[
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
// "A"
let l15 = Letter(style: .line, size: defaultSize, points: [[
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
// "b"
let l16 = Letter(style: .loop, size: mediumSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 3, y: 2.75),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 0, y: 2),
    ]])
// "B"
let l17 = Letter(style: .loop, size: defaultSize, points: [[
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
// "c"
let l18 = Letter(style: .line, size: mediumSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 0, y: 2.75),
        CGPoint(x: 0, y: 5.25),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 6),
    ]])
// "C"
let l19 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 4, y: 6),
    ]])
// "D"
let l20 = Letter(style: .loop, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
// "𝚎"
let l21 = Letter(style: .line, size: mediumSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 3, y: 6),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
    ]])
// "e"
let l22 = Letter(style: .line, size: mediumSize, points: [[
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
        CGPoint(x: 3, y: 2),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 3, y: 6),
    ]])
// "E"
let l23 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 3, y: 3),
    ]])
// "F"
let l24 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1.5, y: 3),
    ]])
// "g"
let l25 = Letter(style: .line, size: defaultSize, points: [[
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
// "G"
let l26 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 3, y: 3),
    ]])
// "H"
let l27 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6.25),
    ], [
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ], [
        CGPoint(x: 4, y: -0.25),
        CGPoint(x: 4, y: 6.25),
    ]])
// "i"
let l28 = Letter(style: .line, size: CGSize(width: 2, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: 1.75),
        CGPoint(x: 1, y: 6.25),
    ], [
        CGPoint(x: 1, y: 0.2),
        CGPoint(x: 1, y: 0.7),
    ]])
// "I"
let l29 = Letter(style: .line, size: CGSize(width: 2, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: -0.25),
        CGPoint(x: 1, y: 6.25),
    ]])
// "J"
let l30 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4, y: -0.25),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 4),
    ]])
// "K"
let l31 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6.25),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 6),
    ]])
// "l"
let l32 = Letter(style: .line, size: narrowSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 1, y: 6),
    ]])
// "L"
let l33 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]])
// "M"
let l34 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 4, y: 6.25),
    ]])
// "n"
let l35 = Letter(style: .line, size: mediumSize, points: [[
        CGPoint(x: 0, y: 1.75),
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2.5, y: 2),
        CGPoint(x: 3, y: 2.5),
        CGPoint(x: 3, y: 6.25),
    ]])
// "N"
let l36 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: -0.25),
    ]])
// "o"
let l37 = Letter(style: .loop, size: mediumSize, points: [[
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 3, y: 2.75),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5.25),
        CGPoint(x: 0, y: 2.75),
    ]])
// "O"
let l38 = Letter(style: .loop, size: defaultSize, points: [[
        CGPoint(x: 1, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 1),
    ]])
// "P"
let l39 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0, y: 3),
    ]])
// "Q"
let l40 = Letter(style: .loop, size: defaultSize, points: [[
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
// "r"
let l41 = Letter(style: .line, size: CGSize(1.75, defaultSize.height), points: [[
        CGPoint(x: 0, y: 1.75),
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 2, y: 2),
    ]])
// "R"
let l42 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 0, y: 0),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 4, y: 1),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 3, y: 3),
        CGPoint(x: 0.5, y: 3),
        CGPoint(x: 4, y: 6.25),
    ]])
// "s"
let l43 = Letter(style: .line, size: mediumSize, points: [[
        CGPoint(x: 3, y: 2),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 0, y: 2.75),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 3, y: 4),
        CGPoint(x: 3, y: 5.25),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
// "S"
let l44 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 1, y: 0),
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 0, y: 6),
    ]])
// "t"
let l45 = Letter(style: .line, size: mediumSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 3, y: 2),
    ], [
        CGPoint(x: 1.5, y: 1),
        CGPoint(x: 1.5, y: 6.25),
    ]])
// "T"
let l46 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6.25),
    ]])
// "U"
let l47 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: -0.25),
        CGPoint(x: 0, y: 5),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 6),
        CGPoint(x: 4, y: 5),
        CGPoint(x: 4, y: -0.25),
    ]])
// "V"
let l48 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 4, y: 0),
    ]])
// "W"
let l49 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 0),
    ]])
// "X"
let l50 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 6),
    ], [
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 0),
    ]])
// "Y"
let l51 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 3),
        CGPoint(x: 4, y: 0),
    ], [
        CGPoint(x: 2, y: 3),
        CGPoint(x: 2, y: 6.25),
    ]])
// "Z"
let l52 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
    ]])
// "π"
let l53 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 1, y: 2),
        CGPoint(x: 1, y: 6),
    ], [
        CGPoint(x: 3, y: 2),
        CGPoint(x: 3, y: 6),
    ]])
// "τ"
let l54 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 2, y: 2),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 3, y: 6),
    ]])
// "𝑒"
let l55 = Letter(style: .line, size: defaultSize, points: [[
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
// "𝑓"
let l56 = Letter(style: .line, size: CGSize(width: 3, height: defaultSize.height), points: [[
        CGPoint(x: 3, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 0, y: 6),
    ], [
        CGPoint(x: 0.5, y: 3),
        CGPoint(x: 2.5, y: 3),
    ]])
// "𝑥"
let l57 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0.5, y: 2),
        CGPoint(x: 3.5, y: 6),
        CGPoint(x: 4, y: 5.5),
    ], [
        CGPoint(x: 0, y: 6.25),
        CGPoint(x: 4, y: 1.75),
    ]])
// "𝑦"
let l58 = Letter(style: .line, size: defaultSize, points: [[
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
// "𝑧"
let l59 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2.5),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 4, y: 6),
        CGPoint(x: 4, y: 5.5),
    ]])
// "?"
let l60 = Letter(style: .line, size: mediumSize, points: [[
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
// "/"
let l61 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 6),
    ]])
// "("
let l62 = Letter(style: .line, size: CGSize(width: 1, height: defaultSize.height), points: [[
        CGPoint(x: 1, y: -0.5),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 1, y: 6.5),
    ]])
// ")"
let l63 = Letter(style: .line, size: CGSize(width: 1, height: defaultSize.height), points: [[
        CGPoint(x: 0, y: -0.5),
        CGPoint(x: 1, y: 2),
        CGPoint(x: 1, y: 4),
        CGPoint(x: 0, y: 6.5),
    ]])
// "!"
let l64 = Letter(style: .line, size: CGSize(width: 0.5, height: defaultSize.height), points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 0, y: 5),
    ], [
        CGPoint(x: -0.25, y: 6),
        CGPoint(x: 0.25, y: 6),
    ]])
// "↓"
let l65 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 6),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 4, y: 4),
    ]])
// "↑"
let l66 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 2, y: 6),
        CGPoint(x: 2, y: 0),
    ], [
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 4, y: 2),
    ]])
// "→"
let l67 = Letter(style: .line, size: CGSize(width: 6, height: 4), points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 6, y: 2),
    ], [
        CGPoint(x: 4, y: 0),
        CGPoint(x: 6, y: 2),
        CGPoint(x: 4, y: 4),
    ]])
// "←"
let l68 = Letter(style: .line, size: CGSize(width: 6, height: 4), points: [[
        CGPoint(x: 6, y: 2),
        CGPoint(x: 0, y: 2),
    ], [
        CGPoint(x: 2, y: 0),
        CGPoint(x: 0, y: 2),
        CGPoint(x: 2, y: 4),
    ]])
// ">"
let l69 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 4, y: 3),
        CGPoint(x: 0, y: 6),
    ]])
// "<"
let l70 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 4, y: 0),
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 6),
    ]])
// "⌫"
let l71 = Letter(style: .loop, size: CGSize(5, defaultSize.height), points: [[
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
// "="
let l72 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 2),
        CGPoint(x: 4, y: 2),
    ], [
        CGPoint(x: 0, y: 4),
        CGPoint(x: 4, y: 4),
    ]])
// "+"
let l73 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ], [
        CGPoint(x: 2, y: 1),
        CGPoint(x: 2, y: 5),
    ]])
// "-"
let l74 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0, y: 3),
        CGPoint(x: 4, y: 3),
    ]])
// "÷"
let l75 = Letter(style: .line, size: defaultSize, points: [[
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
// "×"
let l76 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: 0.5, y: 1.5),
        CGPoint(x: 3.5, y: 4.5),
    ], [
        CGPoint(x: 3.5, y: 1.5),
        CGPoint(x: 0.5, y: 4.5),
    ]])
// "±" - plus and divide
let l77 = Letter(style: .line, size: doubleWidthSize, points: [[
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
    ], [
        CGPoint(x: 4.5, y: 2),
        CGPoint(x: 7.5, y: 2),
    ], [
        CGPoint(x: 5, y: 5),
        CGPoint(x: 7, y: 7),
    ], [
        CGPoint(x: 7, y: 5),
        CGPoint(x: 5, y: 7),
    ]])
// "√"
let l78 = Letter(style: .line, size: defaultSize, points: [[
        CGPoint(x: -0.5, y: 4),
        CGPoint(x: 0, y: 4),
        CGPoint(x: 1, y: 6),
        CGPoint(x: 3, y: 0),
        CGPoint(x: 5, y: 0),
    ]])
// "▝" - exponentiation
let l79 = Letter(style: .loop, size: narrowSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 0, y: 2),
    ]])
// "ₒ"
let l80 = Letter(style: .loop, size: narrowSize, points: [[
        CGPoint(x: 0, y: 6),
        CGPoint(x: 2, y: 6),
        CGPoint(x: 2, y: 8),
        CGPoint(x: 0, y: 8),
    ]])
// "◻"
let l81 = Letter(style: .loop, size: mediumSize, points: [[
        CGPoint(x: 0, y: 1.5),
        CGPoint(x: 3, y: 1.5),
        CGPoint(x: 3, y: 4.5),
        CGPoint(x: 0, y: 4.5),
    ]])
// "◼"
let l82 = Letter(style: .fill, size: mediumSize, points: [[
        CGPoint(x: 0, y: 1.5),
        CGPoint(x: 3, y: 1.5),
        CGPoint(x: 3, y: 4.5),
        CGPoint(x: 0, y: 4.5),
    ]])
// "^"
let l83 = Letter(style: .line, size: mediumSize, points: [[
        CGPoint(x: -0.5, y: 3),
        CGPoint(x: 1.5, y: 1),
        CGPoint(x: 3.5, y: 3),
    ]])
// "ⁿ"
let l84 = Letter(style: .loop, size: mediumSize, points: [[
        CGPoint(x: 0, y: 0),
        CGPoint(x: 2, y: 0),
        CGPoint(x: 2, y: 2),
        CGPoint(x: 0, y: 2),
    ]])

let DefaultFont = Font(
    stroke: 0.5,
    scale: 3,
    space: 2,
    art: [
    " ": l0,
    "␠": l1,
    ".": l2,
    ",": l3,
    "0": l4,
    "1": l5,
    "2": l6,
    "3": l7,
    "4": l8,
    "5": l9,
    "6": l10,
    "7": l11,
    "8": l12,
    "9": l13,
    "a": l14,
    "A": l15,
    "b": l16,
    "B": l17,
    "c": l18,
    "C": l19,
    "D": l20,
    "𝚎": l21,
    "e": l22,
    "E": l23,
    "F": l24,
    "g": l25,
    "G": l26,
    "H": l27,
    "i": l28,
    "I": l29,
    "J": l30,
    "K": l31,
    "l": l32,
    "L": l33,
    "M": l34,
    "n": l35,
    "N": l36,
    "o": l37,
    "O": l38,
    "P": l39,
    "Q": l40,
    "r": l41,
    "R": l42,
    "s": l43,
    "S": l44,
    "t": l45,
    "T": l46,
    "U": l47,
    "V": l48,
    "W": l49,
    "X": l50,
    "Y": l51,
    "Z": l52,
    "π": l53,
    "τ": l54,
    "𝑒": l55,
    "𝑓": l56,
    "𝑥": l57,
    "𝑦": l58,
    "𝑧": l59,
    "?": l60,
    "/": l61,
    "(": l62,
    ")": l63,
    "!": l64,
    "↓": l65,
    "↑": l66,
    "→": l67,
    "←": l68,
    ">": l69,
    "<": l70,
    "⌫": l71,
    "=": l72,
    "+": l73,
    "-": l74,
    "÷": l75,
    "×": l76,
    "±": l77,
    "√": l78,
    "▝": l79,
    "ₒ": l80,
    "◻": l81,
    "◼": l82,
    "^": l83,
    "ⁿ": l84,
])
