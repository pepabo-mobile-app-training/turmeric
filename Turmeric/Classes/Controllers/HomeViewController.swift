import UIKit
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController {
    var lists: [List]?

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

        // AppDelegateにあるログイン処理が実行される前に読み込まれてしまうので、ひとまず対策
        User.authenticate(parameters: ["user": ["email": "syuta_ogido@yahoo.co.jp", "password": "testtest"]]) { response in
            User.getMyLists() { lists in
                self.lists = lists
                self.reloadPagerTabStripView()
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
        let homeTab = [createFeedViewController(title: "Home")]

        // リストがなければすぐにreturn
        guard let myLists = self.lists else {
            return homeTab
        }

        let listTabs = myLists.map { (list) in
            createFeedViewController(title: list.name)
        }
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
