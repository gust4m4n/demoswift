import UIKit

class DemoImageSliderController : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var list: [String] = []
    var index: Int = 0
    
    convenience init (list: [String], index: Int) {
        self.init()
        self.list = list
        self.index = index
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: DemoDemoImageSliderCell.className(), bundle: nil), forCellWithReuseIdentifier: DemoDemoImageSliderCell.className())
        self.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let _ = self.collectionView.setSlideShowLayout(width: self.view.frame.size.width, columns: 1, gridWidth: 0.0, itemAspectRatio: self.view.frame.size.height/self.view.frame.size.width, headerSize: CGSize(width: 0.0, height: 0.0))
        self.collectionView.isPagingEnabled = false
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: false)
        self.collectionView.isPagingEnabled = true
        updateTitle()
    }
        
    @IBAction func btnBackClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateTitle() {
        let count = self.list.count
        let visibleCells = collectionView.visibleCells
        if let firstCell = visibleCells.first {
            if let indexPath = collectionView.indexPath(for: firstCell as UICollectionViewCell) {
                self.title = "\(indexPath.row+1) of \(count)"
            }
        }
    }

    deinit {
    }

}

extension DemoImageSliderController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfSectionInCollectionView section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DemoDemoImageSliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoDemoImageSliderCell.className(), for: indexPath) as! DemoDemoImageSliderCell
        cell.iv.source(url: list[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension DemoImageSliderController : UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            updateTitle()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateTitle()
    }
}
