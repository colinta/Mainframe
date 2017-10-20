public extension String {

    func withCommas() -> String {
        guard Decimal(string: self) != nil else { return self }

        if hasPrefix(".") {
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
            for c in characters.reversed() {
                if count == 0 && retval != "" {
                    retval = "," + retval
                }
                count = (count + 1) % 3
                retval = String(c) + retval
            }
            return retval.replacingOccurrences(of: "-,", with: "-")
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
