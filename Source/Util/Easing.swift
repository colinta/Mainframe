//
//  Easing.swift
//  FlatoutWar
//
//  Created by Colin Gray on 8/24/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
//

typealias EasingEquation = (time: CGFloat, initial: CGFloat, final: CGFloat) -> CGFloat

func easeLinear(time time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }
    return initial + (finalValue - initial) * time
}

func easeOutExpo(time time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }
    let delta = finalValue - initial
    let dist: CGFloat = 1 - pow(2, -10 * time)
    return delta * dist + initial
}

func easeOutCubic(time time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }
    let delta = finalValue - initial
    let dist = pow(time - 1, 3) + 1
    return delta * dist + initial
}

func easeOutElastic(time time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }

    let p: CGFloat = 0.3
    let s = p / 4

    return (finalValue - initial) * pow(2, -10 * time) * sin((time - s) * TAU / p) + finalValue
}

func easeInElastic(time time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }
    return easeOutElastic(time: 1 - time, initial: finalValue, final: initial)
}

func easeInBack(time time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    let s: CGFloat = 1.70158
    return (finalValue - initial) * time * time * ((s + 1) * time - s) + initial
}

enum Easing {
    case Linear
    case EaseInBack
    case EaseInElastic
    case EaseOutCubic
    case EaseOutElastic
    case EaseOutExpo
    case Custom(EasingEquation)

    var ease: EasingEquation {
        switch self {
        case Linear: return easeLinear
        case EaseInElastic: return easeInElastic
        case EaseInBack: return easeInBack
        case EaseOutCubic: return easeOutCubic
        case EaseOutElastic: return easeOutElastic
        case EaseOutExpo: return easeOutExpo
        case let Custom(eq): return eq
        }
    }

}
