import UIKit

extension UIView {
    
    func renderToPDF() -> NSData {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.bounds, nil)
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height), nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else {
            return NSData()
        }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        return pdfData
    }
    
    func savePDF(filename: String) -> URL? {
        let pdfData = renderToPDF()
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let actualPath = resourceDocPath.appendingPathComponent(filename)
        do {
            try pdfData.write(to: actualPath, options: .atomic)
            return actualPath
        } catch {
            return nil
        }
    }
    
}

