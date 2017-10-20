////
///  Easing.swift
//

typealias EasingEquation = (CGFloat, CGFloat, CGFloat) -> CGFloat

func _easeLinear(time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }
    return initial + (finalValue - initial) * time
}

func _easeOutExpo(time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }
    let delta = finalValue - initial
    let dist: CGFloat = 1 - pow(2, -10 * time)
    return delta * dist + initial
}

func _easeOutCubic(time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }
    let delta = finalValue - initial
    let dist = pow(time - 1, 3) + 1
    return delta * dist + initial
}

func _easeOutElastic(time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }

    let p: CGFloat = 0.3
    let s = p / 4

    return (finalValue - initial) * pow(2, -10 * time) * sin((time - s) * TAU / p) + finalValue
}

func _easeInElastic(time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    guard time > 0 else { return initial }
    guard time < 1 else { return finalValue }
    return _easeOutElastic(time: 1 - time, initial: finalValue, final: initial)
}

func _easeInBack(time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    let s: CGFloat = 1.70158
    return (finalValue - initial) * time * time * ((s + 1) * time - s) + initial
}

func _easeReverseQuad(time: CGFloat, initial: CGFloat = 0, final finalValue: CGFloat = 1) -> CGFloat {
    let a = 4 * (initial - finalValue)
    let b = 4 * (finalValue - initial)
    return a * pow(time, 2) + b * time + initial
}

enum Easing {
    case linear
    case inBack
    case inElastic
    case outCubic
    case outElastic
    case outExpo
    case reverseQuad
    case custom(EasingEquation)

    func ease(time: CGFloat, initial: CGFloat = 0, final: CGFloat = 1) -> CGFloat {
        switch self {
        case .linear: return _easeLinear(time: time, initial: initial, final: final)
        case .inElastic: return _easeInElastic(time: time, initial: initial, final: final)
        case .inBack: return _easeInBack(time: time, initial: initial, final: final)
        case .outCubic: return _easeOutCubic(time: time, initial: initial, final: final)
        case .outElastic: return _easeOutElastic(time: time, initial: initial, final: final)
        case .outExpo: return _easeOutExpo(time: time, initial: initial, final: final)
        case .reverseQuad: return _easeReverseQuad(time: time, initial: initial, final: final)
        case let .custom(equation): return equation(time, initial, final)
        }
    }

}

