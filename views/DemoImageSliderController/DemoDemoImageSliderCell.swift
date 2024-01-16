import UIKit
import SwiftyJSON

class DemoDemoImageSliderCell: UICollectionViewCell {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var iv: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 32.0
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
        self.scrollView.contentOffset = CGPoint(x: 0.0, y: 0)
        self.iv.frame = CGRect(x: 0.0, y: 0.0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = UIColor.clear
        }
    }
    
    func load(model: JSON) {
        iv.source(url: model["image_url"].stringValue.urlString(), placeholder: "ic_img_pholder.png")
        self.layoutIfNeeded()
    }

}

extension DemoDemoImageSliderCell: UIScrollViewDelegate{
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.iv
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
    }
}

