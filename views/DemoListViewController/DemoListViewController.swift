import UIKit
import SDWebImage

class DemoListViewController : UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let movieListVM = DemoMovieListVM()
    var shimmering = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: DemoListViewCell.className(), bundle: nil), forCellReuseIdentifier: DemoListViewCell.className())
        self.shimmering = true
        self.movieListVM.request(completion: {(_ resp: ApiXResponse) in
            self.shimmering = false
            self.tableView.reloadData()
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

extension DemoListViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shimmering == true {
            return 16
        } else {
            return self.movieListVM.list.count
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DemoListViewCell.className(), for: indexPath) as! DemoListViewCell
        cell.shimmering(on: shimmering)
        if shimmering == false {
            cell.setMovie(self.movieListVM.list[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.view.endEditing(true)
        let movie = self.movieListVM.list[indexPath.row]
        let controller = DemoImageSliderController(list: [movie.poster], index: 0)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

