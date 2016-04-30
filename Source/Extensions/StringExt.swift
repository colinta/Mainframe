public extension String {
    func beginsWith(str: String) -> Bool {
        if let range = self.rangeOfString(str) {
            return range.startIndex == self.startIndex
        }
        return false
    }

    func endsWith(str: String) -> Bool {
        if let range = self.rangeOfString(str, options: .BackwardsSearch) {
            return range.endIndex == self.endIndex
        }
        return false
    }

    func contains(string: String) -> Bool {
        return self.rangeOfString(string, options: .CaseInsensitiveSearch) != .None
    }

    func withCommas() -> String {
        guard NSDecimalNumber(string: self) != NSDecimalNumber.notANumber() else { return self }

        if beginsWith(".") {
            var found = false
            let parts = characters.split {
                if $0 == "." && !found {
                    found = true
                    return true
                }
                return false
            }.map { String($0) }

            let rhs = parts.safe(0) ?? ""
            return "0." + rhs.withSpaces()
        }
        else if contains(".") {
            var found = false
            let parts = characters.split {
                if $0 == "." && !found {
                    found = true
                    return true
                }
                return false
            }.map { String($0) }

            let (lhs, rhs) = (parts.safe(0) ?? "", parts.safe(1) ?? "")
            return lhs.withCommas() + "." + rhs.withSpaces()
        }
        else {
            var retval = ""
            var count = 0
            for c in characters.reverse() {
                if count == 0 && retval != "" {
                    retval = "," + retval
                }
                count = (count + 1) % 3
                retval = String(c) + retval
            }
            return retval.stringByReplacingOccurrencesOfString("-,", withString: "-")
        }
    }

    private func withSpaces() -> String {
        var retval = ""
        var count = 0
        for c in characters {
            if count == 0 && retval != "" {
                retval += "␠"
            }
            count = (count + 1) % 3
            retval += String(c)
        }
        return retval
    }
}
