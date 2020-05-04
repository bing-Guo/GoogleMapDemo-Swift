import Foundation
import CoreLocation

class LocationManager: NSObject {
    private static var sharedInstance: LocationManager = {
        return LocationManager()
    }()
    private(set) var isAllowed: Bool = false
    private(set) var position: Position = Position(lat: 25.0472903, long: 121.517323) // Default 台北火車站
    private var locationManager: CLLocationManager!
    
    class func shared() -> LocationManager {
        return sharedInstance
    }
    
    private init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    func askUserLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            self.isAllowed = true
            break
        case .authorizedWhenInUse:
            self.isAllowed = true
            break
        case .denied:
            self.isAllowed = false
            break
        case .notDetermined:
            self.isAllowed = false
            break
        case .restricted:
            self.isAllowed = false
            break
        @unknown default:
            fatalError("Unknow status of CLAuthorizationStatus.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let position = Position(lat: (location?.coordinate.latitude)!, long: (location?.coordinate.longitude)!)
        self.position = position
        self.locationManager.stopUpdatingLocation()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "LocationAuthorization"), object: self, userInfo: ["Status": self.isAllowed])
    }
}
