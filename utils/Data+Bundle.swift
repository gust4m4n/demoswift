import UIKit

extension Data {
    
    init(res: String) {
        self.init()
        if let url = Bundle.main.url(forResource: res.fileName(), withExtension: res.fileExtension()) {
            do {
                let data = try Data(contentsOf: url)
                self = data
            } catch {
            }
        }
    }

}
