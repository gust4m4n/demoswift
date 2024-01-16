import UIKit

extension UIImage {
    
    func centerCropIdCard(width: CGFloat, height: CGFloat) -> UIImage? {
        let cropRect = CGRect(x: (size.width / 2.0) - (width / 2.0), y: (size.height / 2.0) - (height / 2.0), width: width, height: height).integral
        if let sourceCGImage = self.fixOrientation().cgImage {
            if let croppedCGImage = sourceCGImage.cropping(to: cropRect) {
                let result = UIImage(cgImage: croppedCGImage)
                return result.fixOrientation()
            }
        }
        return nil
    }
    
    func fixOrientation() -> UIImage {

            guard let cgImage = cgImage else { return self }

            if imageOrientation == .up { return self }

            var transform = CGAffineTransform.identity

            switch imageOrientation {

            case .down, .downMirrored:
                transform = transform.translatedBy(x: size.width, y: size.height)
                transform = transform.rotated(by: CGFloat(M_PI))

            case .left, .leftMirrored:
                transform = transform.translatedBy(x: size.width, y: 0)
                transform = transform.rotated(by: CGFloat(M_PI_2))

            case .right, .rightMirrored:
                transform = transform.translatedBy(x: 0, y: size.height)
                transform = transform.rotated(by: CGFloat(-M_PI_2))

            case .up, .upMirrored:
                break
            }

            switch imageOrientation {

            case .upMirrored, .downMirrored:
                transform.translatedBy(x: size.width, y: 0)
                transform.scaledBy(x: -1, y: 1)

            case .leftMirrored, .rightMirrored:
                transform.translatedBy(x: size.height, y: 0)
                transform.scaledBy(x: -1, y: 1)

            case .up, .down, .left, .right:
                break
            }

            if let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {

                ctx.concatenate(transform)

                switch imageOrientation {

                case .left, .leftMirrored, .right, .rightMirrored:
                    ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))

                default:
                    ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                }

                if let finalImage = ctx.makeImage() {
                    return (UIImage(cgImage: finalImage))
                }
            }

            // something failed -- return original
            return self
        
    }

}
