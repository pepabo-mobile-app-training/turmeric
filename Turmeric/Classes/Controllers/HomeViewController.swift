import UIKit
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController, PerformSegueToProfileDelegate {
    var lists: [List] = []

    var selectedUser: User! = nil;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        User.getMyLists() { response in
            switch response {
            case .Success(let lists):
                self.lists = lists!
                self.reloadPagerTabStripView()
            default: break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ナビから戻ってきたらタブを復活させる
        let subviews = navigationController?.navigationBar.subviews
        for subview in subviews! {
            subview.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        // タブのデザイン
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor(red: 37/255.0, green: 111/255.0, blue: 206/255.0, alpha: 1.0)
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        super.viewDidLoad()
        // NavigationBarにButtonBar(タブ)を置く
        // buttonBarViewはスーパークラスで定義されている
        buttonBarView.removeFromSuperview()
        navigationController?.navigationBar.addSubview(buttonBarView)
        
        // タブ切り替え時の処理
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .gray    // 非アクティブタグはグレー
            newCell?.label.textColor = .black   // アクティブタグは黒
            
            // アクティブの文字は大きく、非アクティブは小さく表示する
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            }
            else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // それぞれのタブとなるViewControlerを返す
    // 必ずオーバーライドする必要がある
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        // ホームのフィードは必ず作成
        let homeTab = [createFeedViewController(endpoint: Endpoint.MyFeed, title: "Home")]
        // リストがあればリストフィードを作成
        let listTabs = self.lists.map { createFeedViewController(endpoint: Endpoint.ListFeed($0.id), title: $0.name) }
        return homeTab + listTabs
    }

    override func reloadPagerTabStripView() {
        // タブ更新時に独自の処理をさせたければここに書く
        super.reloadPagerTabStripView()
    }

    private func createFeedViewController(endpoint: Endpoint, title: String) -> FeedViewController {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        let feed = storyboard.instantiateInitialViewController() as! FeedViewController
        feed.endpoint = endpoint
        feed.itemInfo = IndicatorInfo(title: title)
        feed.isHome = true
        return feed
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profile"){
            // navbarをナビに使うのでタブを退場させる
            let subviews = navigationController?.navigationBar.subviews
            for subview in subviews! {
                subview.isHidden = true
            }
            
            let vc = segue.destination as! OthersProfileViewController
            vc.user = self.selectedUser
        }
    }
    
    func performSegueToProfile(user: User) {
        self.selectedUser = user
        performSegue(withIdentifier: "profile", sender: self)
    }
}
