import Foundation

class LocationManagerInitializer {
    func setup() {
        LocationManager.shared().askUserLocationAuthorization()
    }
}
