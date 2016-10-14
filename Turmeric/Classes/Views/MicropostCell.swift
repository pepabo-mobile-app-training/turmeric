import UIKit

class MicropostCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 1.0, green: 236/255.0, blue: 179/255.0, alpha: 1.0)
        self.selectedBackgroundView = bgView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
