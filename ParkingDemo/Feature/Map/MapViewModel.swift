import Foundation
import GoogleMaps

class MapViewModel {
    
    // MARK: - Private
    
    private let pinsService: PinsServiceProtocol
    private let locationManager: LocationManager = LocationManager.shared()
    private var cameraZoom: Float = 15
    var selectedParkingTitle: String?
    var selectedPin: Pin? {
        return self.pins.filter( {$0.title == self.selectedParkingTitle!} ).first
    }
    
    // MARK: - Output
    
    private var pins: [Pin] = [Pin]() {
        didSet {
            self.reloadPinsClosure?()
        }
    }
    
    // MARK: - Closure
    
    var updateMapPositionClosure: (()->())?
    var reloadPinsClosure: (()->())?
    
    // MARK: Constructor
    init(pinsService: PinsServiceProtocol = PinsService()) {
        self.pinsService = pinsService
        
        // it will be called when location is updating
        NotificationCenter.default.addObserver(self, selector: #selector(locationAuthorizationHandler), name: Notification.Name(rawValue: "LocationAuthorization"), object: nil)
    }
}

// MARK: - Pins

extension MapViewModel {
    func initFetchPins() {
        self.pinsService.fetchAllPins { [weak self] pins in
            self?.pins = pins
        }
    }
    
    func getAllPins() -> [Pin] {
        return self.pins
    }
}

// MARK: - Location

extension MapViewModel {
    func getUserCurrentCameraPosition() -> GMSCameraPosition {
        let position = locationManager.position
        let camera = GMSCameraPosition(latitude: position.lat, longitude: position.long, zoom: self.cameraZoom)
        
        return camera
    }
    
    // MARK: - Action
    
    @objc func locationAuthorizationHandler() {
        if locationManager.isAllowed {
            self.updateMapPositionClosure!()
        } else {
            // TODO
            fatalError("Error Handling")
        }
        
    }
}

