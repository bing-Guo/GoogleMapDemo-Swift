import Foundation
import GoogleMaps

protocol PinsServiceProtocol {
    func fetchAllPins( complete: @escaping ([Pin]) -> () )
    func fetchPinByTitle( title: String, complete: @escaping (Pin) -> () )
}

class PinsService: PinsServiceProtocol {
    func fetchAllPins( complete: @escaping ([Pin]) -> () ) {
        DispatchQueue.global().async {
            sleep(1)
            let path = Bundle.main.path(forResource: "Pins", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let pinsResult = try! decoder.decode(PinsResult.self, from: data)
            
            complete( pinsResult.result )
        }
    }
    
    func fetchPinByTitle( title: String, complete: @escaping (Pin) -> () ) {
        DispatchQueue.global().async {
            sleep(1)
            let path = Bundle.main.path(forResource: "Pins", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let pinsResult = try! decoder.decode(PinsResult.self, from: data)
            let pin = pinsResult.result.filter( { $0.title == title } ).first!
            
            complete( pin )
        }
    }
}
