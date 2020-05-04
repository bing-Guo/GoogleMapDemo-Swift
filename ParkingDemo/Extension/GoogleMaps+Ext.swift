import Foundation
import GoogleMaps

extension GMSMarker {
    convenience init(lat: Double, long: Double, title: String, map: GMSMapView) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image = UIImage(named: "parking-pin")
        
        self.init(position: CLLocationCoordinate2D(latitude: lat, longitude: long))
        self.title = title
        self.map = map
        self.iconView = imageView
        self.tracksViewChanges = true
    }
}
