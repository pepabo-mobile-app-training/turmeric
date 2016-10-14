import UIKit
import XLPagerTabStrip

class FeedViewController: UITableViewController, IndicatorInfoProvider {
    var itemInfo = IndicatorInfo(title: "Feed")
    var endpoint: Endpoint?
    var microposts = [Micropost]()

    var isHome: Bool = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 「引っ張って更新」
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "引っ張って更新")
        self.refreshControl?.addTarget(self, action: #selector(FeedViewController.reloadFeed), for: UIControlEvents.valueChanged)

        tableView.register(UINib(nibName: "MicropostCell", bundle: nil), forCellReuseIdentifier: "micropostCell")
        // あらかじめセルの高さの概算値を設定しておいて、実際の計算処理を遅延させる
        // 実際に表示される高さに近くしておくとカクカクしにくくなるらしい
        tableView.estimatedRowHeight = 60
        // セルの高さを自動計算する
        tableView.rowHeight = UITableViewAutomaticDimension

        reloadFeed()
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
        let micropost = self.microposts[indexPath.row]
        cell.name.text = micropost.user.name
        cell.content.text = micropost.content
        cell.profileImage.af_setImage(withURL: micropost.user.iconURL)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        cell.date.text = formatter.string(for: micropost.createdAt)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = self.microposts[indexPath.row].user
        let parent = self.parent as! PerformSegueToProfileDelegate
        
        parent.performSegueToProfile(user: selectedUser)
    }
    
    // ヘッダフッタを作ってリストタブ・タブバーにめり込むのを防ぐ
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isHome ? 20 : 0
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return isHome ? 49 : 0
    }
    
    // デフォルトだとヘッダ・フッタに色が入るので透明にしておく
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }

    func reloadFeed() {
        // endpointが指定されていなければ何もしない
        guard let endpoint = self.endpoint else { return }
        
        Micropost.getFeed(endpoint: endpoint) { response in
            switch response {
            case .Success(let feed):
                self.microposts = feed!
                self.tableView.reloadData()
                // endRefreshingしないとローディングアイコンが回り続ける
                self.refreshControl?.endRefreshing()
            default: break
            }
        }
    }
}
