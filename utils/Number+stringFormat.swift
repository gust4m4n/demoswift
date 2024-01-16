extension Int {
    func format(group: String = ",", dec: String = ".") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = group
        formatter.decimalSeparator = dec
        return formatter.string(for: self)!
    }
}

extension Int64 {
    func format(group: String = ",", dec: String = ".") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = group
        formatter.decimalSeparator = dec
        return formatter.string(for: self)!
    }
}

extension Double {
    func format(group: String = ",", dec: String = ".", fractionDigits: Int = 3) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = group
        formatter.decimalSeparator = dec
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(for: self)!
    }
}
