import UIKit

extension UIViewController {

    func setNavigationBarTitleImage(_ image: UIImage?) {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        imageView.contentMode = .scaleAspectFit
        if let img = image {
            imageView.image = img
        }
        let contentView = UIView()
        contentView.backgroundColor = .clear
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}


