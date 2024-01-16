import UIKit

extension UIImage {
    
    func blur(factor: CGFloat = 4.5) -> UIImage? {
        guard let inputImage = CIImage(image: self) else {
            return nil
        }
        let gaussianFilter = CIFilter(name: "CIGaussianBlur")
            gaussianFilter?.setValue(inputImage, forKey: kCIInputImageKey)
            gaussianFilter?.setValue(factor, forKey: kCIInputRadiusKey)
        guard let outputImage = gaussianFilter?.outputImage else {
            return nil
        }
        return UIImage(ciImage: outputImage)
    }

}
