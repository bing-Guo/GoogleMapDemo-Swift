import Foundation
import GoogleMaps
import GooglePlaces

class GoogleMapInitializer {
    let APIKey = "Your Google Map API Key"
    
    func setup() {
        GMSServices.provideAPIKey(APIKey)
        GMSPlacesClient.provideAPIKey(APIKey)
    }
}
