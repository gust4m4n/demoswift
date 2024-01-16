class LoggerX {
    
    static func log(_ text: String) {
        #if DEBUG
        print(text)
        #endif
    }
    
}

