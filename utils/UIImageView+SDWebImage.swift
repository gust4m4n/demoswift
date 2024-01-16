import UIKit
import SDWebImage

extension UIImageView {
    func source(url: String, placeholder: String = "", completion: ((_ image: UIImage?) -> Void)? = nil) {
        if url.count == 0 {
            if placeholder.count > 0 {
                self.image = UIImage(named: placeholder)
            } else {
                self.image = nil
            }
        } else {
            if url.lowercased().range(of: "http://") == nil && url.lowercased().range(of: "https://") == nil {
                self.image = UIImage(named: url)
            } else {
                if let safeUrl = URL(string: url.urlString()) {
                    if placeholder.count > 0 {
                        self.sd_setImage(with: safeUrl, placeholderImage: UIImage(named: placeholder), completed: {
                        (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
                            completion?(image)
                        })
                    } else {
                        self.sd_setImage(with: safeUrl, completed: {
                        (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
                            completion?(image)
                        })
                    }
                } else {
                    self.image = UIImage(named: url)
                }
            }
        }
    }
}

extension UIImageView {
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }

    @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}

