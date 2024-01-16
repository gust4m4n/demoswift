import UIKit
import SwiftyJSON

extension JSON {
    
    init(res: String) {
        if let filepath = Bundle.main.path(forResource: res.fileName(), ofType: res.fileExtension()) {
            do {
                let contents = try String(contentsOfFile: filepath)
                self = JSON(parseJSON: contents)
            } catch {
                self = JSON()
            }
        } else {
            self = JSON()
        }
    }
    
}

