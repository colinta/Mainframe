//
//  FreeMethods.swift
//  FlatoutWar
//
//  Created by Colin Gray on 7/27/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
//

public func inBackground(_ block: @escaping Block) {
    DispatchQueue.global(qos: .userInitiated).async(execute: block)
}

public func inForeground(_ block: @escaping Block) {
    DispatchQueue.main.async(execute: block)
}

public typealias Block = () -> Void
public typealias ConditionBlock = () -> Bool
public typealias ThrottledBlock = (CGFloat, Block) -> Void
public typealias CancellableBlock = (Bool) -> Void
public typealias TakesIndexBlock = (Int) -> Void


infix operator ++ : AdditionPrecedence

func ++ (lhs: @escaping Block, rhs: @escaping Block) -> Block {
    return {
        lhs()
        rhs()
    }
}


public class Proc {
    var block: Block

    public init(_ block: @escaping Block) {
        self.block = block
    }

    @objc
    func run() {
        block()
    }
}


public func times(_ times: Int, block: Block) {
    times_(times) { (index: Int) in block() }
}

public func times(_ times: Int, block: TakesIndexBlock) {
    times_(times, block: block)
}

private func times_(_ times: Int, block: TakesIndexBlock) {
    if times <= 0 {
        return
    }
    var i = 0
    while i < times {
        block(i)
        i += 1
    }
}

extension Int {
    public func times(_ block: Block) {
        times_(self) { (index: Int) in block() }
    }

    public func times(_ block: TakesIndexBlock) {
        times_(self, block: block)
    }
}

public func afterN(_ block: @escaping Block) -> (() -> Block) {
    var remaining = 0
    return {
        remaining += 1
        return {
            remaining -= 1
            if remaining == 0 {
                block()
            }
        }
    }
}

public func after(times: Int, block: @escaping Block) -> Block {
    if times == 0 {
        block()
        return {}
    }

    var remaining = times
    return {
        remaining -= 1
        if remaining == 0 {
            block()
        }
    }
}

public func until(_ times: Int, block: @escaping Block) -> Block {
    if times == 0 {
        return {}
    }

    var remaining = times
    return {
        remaining -= 1
        if remaining >= 0 {
            block()
        }
    }
}

public func once(_ block: @escaping Block) -> Block {
    return until(1, block: block)
}

public func timeout(_ duration: TimeInterval, block: @escaping Block) -> Block {
    let handler = once(block)
    _ = delay(duration) {
        handler()
    }
    return handler
}

public func delay(_ duration: TimeInterval, block: @escaping Block) {
    let proc = Proc(block)
    _ = Timer.scheduledTimer(timeInterval: duration, target: proc, selector: #selector(Proc.run), userInfo: nil, repeats: false)
}

public func delay(_ duration: TimeInterval) -> ThrottledBlock {
    var countdown = duration
    var ranOnce = false
    return { (dt, block) in
        if !ranOnce {
            countdown -= TimeInterval(dt)
            if countdown <= 0 {
                ranOnce = true
                block()
            }
        }
    }
}

public func throttle(_ every: TimeInterval) -> ThrottledBlock {
    var countdown = every

    return { (dt, block) in
        countdown -= TimeInterval(dt)
        if countdown <= 0 {
            countdown = every
            block()
        }
    }
}
