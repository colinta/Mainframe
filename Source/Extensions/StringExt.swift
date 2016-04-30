public extension String {
    func contains(string: String) -> Bool {
        return self.rangeOfString(string, options: .CaseInsensitiveSearch) != .None
    }
    func withCommas() -> String {
        var retval = ""
        var count = 0
        for c in characters.reverse() {
            if count == 0 && retval != "" {
                retval = "," + retval
            }
            count = (count + 1) % 3
            retval = String(c) + retval
        }
        return retval
    }
}
