import UIKit
import SDWebImage

class DemoGridViewController : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let movieListVM = DemoMovieListVM()
    var shimmering = true

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = self.collectionView.setGridLayout(width: UIScreen.main.bounds.size.width - 0.0, columns: 3, gridWidth: 8.0, itemAspectRatio: 3.25/2.0, extraHeight: 0.0, headerSize: CGSize(width: 0.0, height: 0.0))
        self.collectionView.register(UINib(nibName: DemoGridViewCell.className(), bundle: nil), forCellWithReuseIdentifier: DemoGridViewCell.className())
        self.shimmering = true
        self.movieListVM.request(completion: {(_ resp: ApiXResponse) in
            self.shimmering = false
            self.collectionView.reloadData()
        })
    }
            
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func btnBackClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }
        
    deinit {
    }
}

extension DemoGridViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfSectionInCollectionView section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if shimmering == true {
            return 16
        } else {
            return self.movieListVM.list.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DemoGridViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoGridViewCell.className(), for: indexPath) as! DemoGridViewCell
        cell.shimmering(on: shimmering)
        if shimmering == false {
            cell.setMovie(self.movieListVM.list[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let movie = self.movieListVM.list[indexPath.row]
        let controller = DemoImageSliderController(list: [movie.poster], index: 0)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

