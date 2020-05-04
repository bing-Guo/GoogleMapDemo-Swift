import Foundation
import UIKit
import Kingfisher
import GoogleMaps
import GooglePlaces

class ParkingInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var navButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func navButtonPressed(_ sender: Any) {
        let place = viewModel.selectedPin.position
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(place.lat),\(place.long)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }
        } else {
            if let url = URL(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(place.lat),\(place.long)&directionsmode=driving") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    // MARK: - Private
    
    var viewModel: ParkingInfoViewModel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        buttonView.layer.cornerRadius = self.buttonView.frame.width/2
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        tableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        tableView.register(UINib(nibName: "HighlightTableViewCell", bundle: nil), forCellReuseIdentifier: "HighlightTableViewCell")
        
        self.imageView.kf.setImage(with: viewModel.getImageUrl())
    }
}

extension ParkingInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfCell()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.getCellViewModel(indexPath: indexPath)
        
        if cellVM is ParkingInfoTitleCellViewModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell,
                let dataVM = cellVM as? ParkingInfoTitleCellViewModel else { return UITableViewCell() }
            cell.titleLabel.text = dataVM.title
            cell.commentLabel.text = dataVM.comment
            
            return cell
        } else if cellVM is ParkingInfoHighlightCellViewModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightTableViewCell", for: indexPath) as? HighlightTableViewCell,
                let dataVM = cellVM as? ParkingInfoHighlightCellViewModel else { return UITableViewCell() }
            
            cell.titleLabel.text = dataVM.title
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
            if let dataVM = cellVM as? ParkingInfoPhoneCellViewModel {
                cell.titleLabel.text = dataVM.title
                cell.contentLabel.text = dataVM.content
            } else {
                let dataVM = cellVM as! ParkingInfoCellViewModel
                
                cell.titleLabel.text = dataVM.title
                cell.contentLabel.text = dataVM.content
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellVM = viewModel.getCellViewModel(indexPath: indexPath)
        
        if cellVM is ParkingInfoTitleCellViewModel{
            return 85
        } else {
            return 51
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVM = viewModel.getCellViewModel(indexPath: indexPath)
        
        if cellVM is ParkingInfoPhoneCellViewModel {
            let dataVM = cellVM as! ParkingInfoPhoneCellViewModel
            
            let optionMenu = UIAlertController(title: nil, message: "撥打電話", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let callPhoneAction = UIAlertAction(title: "撥打 \(dataVM.content)", style: .default) { (_) in
                if let url = URL(string: "tel://\(dataVM.content)") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.openURL(url)
                    } else {
                        fatalError("This URL is not available.")
                    }
                } else {
                    fatalError("This URL is not correct.")
                }
            }
            
            optionMenu.addAction(callPhoneAction)
            optionMenu.addAction(cancelAction)
            
            present(optionMenu, animated: true, completion: nil)

        }
    }
    
}
