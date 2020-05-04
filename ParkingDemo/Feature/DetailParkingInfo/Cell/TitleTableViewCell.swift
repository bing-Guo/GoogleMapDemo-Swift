import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    var viewModel: ParkingInfoViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
