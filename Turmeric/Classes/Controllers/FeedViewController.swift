import UIKit
import XLPagerTabStrip

class FeedViewController: UITableViewController, IndicatorInfoProvider {
    var itemInfo = IndicatorInfo(title: "Feed")
    var microposts = [Micropost]()
    
    var isHome: Bool = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MicropostCell", bundle: nil), forCellReuseIdentifier: "micropostCell")
        // あらかじめセルの高さの概算値を設定しておいて、実際の計算処理を遅延させる
        // 実際に表示される高さに近くしておくとカクカクしにくくなるらしい
        tableView.estimatedRowHeight = 60
        // セルの高さを自動計算する
        tableView.rowHeight = UITableViewAutomaticDimension

        // AppDelegateからログイン完了の通知を受けたらフィードを取得する
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.loginDispatch.notify(queue: DispatchQueue.main, execute: {
            User.getMyFeed { feed in
                self.microposts = feed!
                self.tableView.reloadData()
            }
        })
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

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(isHome){
            return 20 // タブ分ずらす
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(isHome){
            return 49 // タブバー分ずらす
        }else{
            return 0
        }
    }
}
