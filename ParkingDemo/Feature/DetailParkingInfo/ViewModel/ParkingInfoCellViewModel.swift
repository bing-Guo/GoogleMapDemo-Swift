protocol ParkingInfoCell {}

struct ParkingInfoTitleCellViewModel: ParkingInfoCell {
    var title: String
    var comment: String
}

struct ParkingInfoCellViewModel: ParkingInfoCell {
    var title: String
    var content: String
}

struct ParkingInfoHighlightCellViewModel: ParkingInfoCell {
    var title: String
}

struct ParkingInfoPhoneCellViewModel: ParkingInfoCell {
    var title: String
    var content: String
}
