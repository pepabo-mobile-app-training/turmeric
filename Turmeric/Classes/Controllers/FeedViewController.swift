import UIKit
import XLPagerTabStrip

class FeedViewController: UITableViewController, IndicatorInfoProvider {
    var itemInfo = IndicatorInfo(title: "Feed")
    var microposts = [Micropost]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MicropostCell", bundle: nil), forCellReuseIdentifier: "micropostCell")

        User.getMyFeed { feed in
            self.microposts = feed!
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // IndicatorInfoProviderでが必要なメソッド
    // タブのタイトルなどの情報を返す
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.microposts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "micropostCell", for: indexPath) as! MicropostCell
        cell.profileImage.af_setImage(withURL: URL(string: "https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?s=80")!)

        return cell
    }
}
