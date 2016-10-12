import UIKit
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController {
    var lists: [List] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // AppDelegateからログイン完了の通知を受けたらリストを取得する
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.loginDispatch.notify(queue: DispatchQueue.main, execute: {
            User.getMyLists() { response in
                switch response {
                case .Success(let lists):
                    self.lists = lists!
                    self.reloadPagerTabStripView()
                default: break
                }
            }
        })
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // それぞれのタブとなるViewControlerを返す
    // 必ずオーバーライドする必要がある
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        // ホームのフィードは必ず作成
        let homeTab = [createFeedViewController(title: "Home")]
        // リストがあればリストフィードを作成
        let listTabs = self.lists.map { createFeedViewController(title: $0.name) }
        return homeTab + listTabs
    }

    override func reloadPagerTabStripView() {
        // タブ更新時に独自の処理をさせたければここに書く
        super.reloadPagerTabStripView()
    }

    private func createFeedViewController(title: String) -> FeedViewController {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        let feed = storyboard.instantiateInitialViewController() as! FeedViewController
        feed.itemInfo = IndicatorInfo(title: title)
        return feed
    }
}
