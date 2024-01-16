import UIKit
import SkeletonView

class DemoListViewCell: UITableViewCell {
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted == true {
                self.contentView.backgroundColor = UIColor.white.darker(0.1)
            }
            else {
                self.contentView.backgroundColor = .clear
            }
        }
    }

    func shimmering(on: Bool) {
        if on == true {
            self.iv.showAnimatedGradientSkeleton()
            self.labelName.numberOfLines = 1;
            self.labelName.cornerRadius = 4.0
            self.labelName.showAnimatedGradientSkeleton()
            self.labelPhone.numberOfLines = 1;
            self.labelPhone.cornerRadius = 4.0
            self.labelPhone.showAnimatedGradientSkeleton()
        } else {
            self.iv.hideSkeleton()
            self.labelName.numberOfLines = 0;
            self.labelName.cornerRadius = 0.0
            self.labelName.hideSkeleton()
            self.labelPhone.numberOfLines = 0;
            self.labelPhone.cornerRadius = 0.0
            self.labelPhone.hideSkeleton()
        }
    }

    func setMovie(_ movie: DemoMovieModel) {
        iv.source(url: movie.poster)
        labelName.text = movie.title
        labelPhone.text = "\(movie.revenue)"
    }

}
