import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: - Private
    
    private lazy var viewModel: MapViewModel = {
        return MapViewModel()
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initMapView()
        initVM()
    }
    
    func initMapView() {
        let camera = self.viewModel.getUserCurrentCameraPosition()
        mapView.camera = camera
        
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }
    
    func initVM() {
        viewModel.updateMapPositionClosure = { [weak self] in
            let camera = self?.viewModel.getUserCurrentCameraPosition()
            self?.mapView.animate(to: camera!)
        }
        
        viewModel.reloadPinsClosure = { [weak self] in
            let pins = self?.viewModel.getAllPins()
            
            for pin in pins! {
                DispatchQueue.main.async {
                    _ = GMSMarker(lat: pin.position.lat,
                                  long: pin.position.long,
                                  title: pin.title,
                                  map: self!.mapView)
                }
            }
        }
        
        viewModel.initFetchPins()
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.viewModel.selectedParkingTitle = marker.title
        
        let storyboard = UIStoryboard(name: "ParkingInfo", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ParkingInfoViewController") as? ParkingInfoViewController {
            
            let cellViewModel = ParkingInfoViewModel(pin: viewModel.selectedPin!)
            vc.viewModel = cellViewModel
                
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        return true
    }
}
