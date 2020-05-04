import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var googleMapContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView.layer.zPosition = 1
        googleMapContainerView.layer.zPosition = 0
        
    }
}

