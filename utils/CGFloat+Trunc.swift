extension CGFloat {
    
    public func trunc() -> CGFloat {
        return CGFloat(truncating: NSNumber(value: Float(self)))
    }
    
}
