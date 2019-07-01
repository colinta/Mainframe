////
/// ArrayExt.swift
//


extension Array {
    typealias MatcherFn = (Element) -> Bool

    func safe(_ index: Int) -> Element? {
        return (startIndex..<endIndex).contains(index) ? self[index] : nil
    }

    func zip<T>(_ array: [T]) -> [(Element, T)] {
        var retVal: [(Element, T)] = []
        for (index, item) in array.enumerated() {
            retVal.append((self[index], item))
        }
        return retVal
    }

    func any(_ test: MatcherFn) -> Bool {
        for ob in self {
            if test(ob) {
                return true
            }
        }
        return false
    }

    func firstMatch(_ test: MatcherFn) -> Element? {
        for ob in self {
            if test(ob) {
                return ob
            }
        }
        return nil
    }

    func lastMatch(_ test: MatcherFn) -> Element? {
        var match: Element?
        for ob in self {
            if test(ob) {
                match = ob
            }
        }
        return match
    }

    func all(_ test: MatcherFn) -> Bool {
        for ob in self {
            if !test(ob) {
                return false
            }
        }
        return true
    }

    func rand() -> Element? {
        guard count > 0 else { return nil }
        let i: Int = Int(arc4random_uniform(UInt32(count)))
        return self[i]
    }

    var headAndTail: (Element, [Element])? {
        return (count > 0) ? (self[0], Array(self[1..<count])) : nil
    }

    var headAndHeadAndTail: (Element, Element, [Element])? {
        return (count > 1) ? (self[0], self[1], Array(self[2..<count])) : nil
    }
}

extension Array {
    mutating func removeMatches(test: (Element) -> Bool) {
        while let index = self.firstIndex(where: test) {
            remove(at: index)
        }
    }
}

extension Array where Element: Equatable {
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            remove(at: index)
        }
    }

}
