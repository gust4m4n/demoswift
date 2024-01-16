import UIKit

extension UIImage {
    
    static func generateQR(code: String, width: CGFloat, height: CGFloat) -> UIImage? {
        let data = code.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            if let qrCodeImage = filter.outputImage {
                let transform = CGAffineTransform(scaleX: width / qrCodeImage.extent.size.width, y: height / qrCodeImage.extent.size.height)
                return UIImage(ciImage: qrCodeImage.transformed(by: transform))
            }
        }
        return nil
    }
    
}
