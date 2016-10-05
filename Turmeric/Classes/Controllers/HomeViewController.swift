import UIKit
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // それぞれのタブとなるViewControlerを返す
    // 必ずオーバーライドする必要がある
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        // ViewControlerを作成
        let child1 = FeedViewController(itemInfo: IndicatorInfo(title: "Home"))
        let child2 = FeedViewController(itemInfo: IndicatorInfo(title: "Friends"))

        // 配列で返す
        return [child1, child2]
    }
}
