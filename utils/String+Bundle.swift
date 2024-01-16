import UIKit

extension String {
    
    init(res: String) {
        self.init()
        if let url = Bundle.main.url(forResource: res.fileName(), withExtension: res.fileExtension()) {
            do {
                let contents = try String(contentsOf: url, encoding: .ascii)
                self = contents
            } catch {
                self = ""
            }
        } else {
            self = ""
        }
    }
    
}

