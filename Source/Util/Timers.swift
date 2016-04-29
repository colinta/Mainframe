//
//  FreeMethods.swift
//  FlatoutWar
//
//  Created by Colin Gray on 7/27/2015.
//  Copyright (c) 2015 FlatoutWar. All rights reserved.
//

public func inBackground(block: Block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), block)
}

public func inForeground(block: Block) {
    dispatch_async(dispatch_get_main_queue(), block)
}

public typealias Block = () -> Void
public typealias ConditionBlock = () -> Bool
public typealias ThrottledBlock = (dt: CGFloat, Block) -> Void
public typealias CancellableBlock = Bool -> Void
public typealias TakesIndexBlock = (Int) -> Void


infix operator ++ {
    associativity left
    precedence 150
}

func ++(lhs: Block, rhs: Block) -> Block {
    return {
        lhs()
        rhs()
    }
}


public class Proc {
    var block: Block

    public init(_ block: Block) {
        self.block = block
    }

    @objc
    func run() {
        block()
    }
}


public func times(times: Int, @noescape block: Block) {
    times_(times) { (index: Int) in block() }
}

public func times(times: Int, @noescape block: TakesIndexBlock) {
    times_(times, block: block)
}

private func times_(times: Int, @noescape block: TakesIndexBlock) {
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
    public func times(@noescape block: Block) {
        times_(self) { (index: Int) in block() }
    }

    public func times(@noescape block: TakesIndexBlock) {
        times_(self, block: block)
    }
}

public func afterN(block: Block) -> (() -> Block) {
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

public func after(times: Int, block: Block) -> Block {
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

public func until(times: Int, block: Block) -> Block {
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

public func once(block: Block) -> Block {
    return until(1, block: block)
}

public func timeout(duration: NSTimeInterval, block: Block) -> Block {
    let handler = once(block)
    _ = delay(duration) {
        handler()
    }
    return handler
}

public func delay(duration: NSTimeInterval, block: Block) {
    let proc = Proc(block)
    _ = NSTimer.scheduledTimerWithTimeInterval(duration, target: proc, selector: #selector(Proc.run), userInfo: nil, repeats: false)
}

public func delay(duration: NSTimeInterval) -> ThrottledBlock {
    var countdown = duration
    var ranOnce = false
    return { (dt, block) in
        if !ranOnce {
            countdown -= NSTimeInterval(dt)
            if countdown <= 0 {
                ranOnce = true
                block()
            }
        }
    }
}

public func throttle(every: NSTimeInterval) -> ThrottledBlock {
    var countdown = every

    return { (dt, block) in
        countdown -= NSTimeInterval(dt)
        if countdown <= 0 {
            countdown = every
            block()
        }
    }
}
