import Foundation
import UIKit

class ParkingInfoViewModel {
    
    // MARK: - Input
    
    let selectedPin: Pin
    
    // MARK: - Output
    
    private var imageUrl: String?
    private var viewModels: [ParkingInfoCell] = [ParkingInfoCell]() {
        didSet {
            self.reloadViewClosure?()
        }
    }
    
    // MARK: - Private
    
    // MARK: - Closure
    
    var reloadViewClosure: (()->())?
    
    // MARK: Constructor

    init(pin: Pin) {
        self.selectedPin = pin
        self.processPinInfo(pin: pin)
    }
    
    func processPinInfo(pin: Pin) {
        viewModels = [
            ParkingInfoTitleCellViewModel(title: pin.title, comment: pin.comment),
            ParkingInfoHighlightCellViewModel(title: pin.highlight),
            ParkingInfoCellViewModel(title: "開放時間", content: pin.openTime),
            ParkingInfoCellViewModel(title: "會員收費", content: pin.fee),
            ParkingInfoCellViewModel(title: "入場方式", content: pin.entryMethod),
            ParkingInfoPhoneCellViewModel(title: "聯絡電話", content: pin.phone)
        ]
        
        imageUrl = pin.image
    }
    
    func getNumberOfCell() -> Int {
        return viewModels.count
    }
    
    func getCellViewModel(indexPath: IndexPath) -> ParkingInfoCell {
        return viewModels[indexPath.row]
    }
    
    func getImageUrl() -> URL? {
        guard let url = self.imageUrl else { return nil }
        return URL(string: url)
    }
}

