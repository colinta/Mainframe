////
/// ChevronExt.swift
//

func <<(lhs: UIView, rhs: UIView) {
    lhs.addSubview(rhs)
}

func <<(lhs: UIViewController, rhs: UIViewController) {
    lhs.addChild(rhs)
}

func <<(lhs: SKNode, rhs: SKNode) {
    lhs.addChild(rhs)
}

func << <V>(lhs: inout Array<V>, rhs: V) {
    lhs.append(rhs)
}
