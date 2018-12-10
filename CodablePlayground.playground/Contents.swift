import UIKit
import PlaygroundSupport


let apiKey = "6e1272c89227425c890161300181012"

enum CurrentWeatherRequest: NetworkRequest {
    case location(latitude: Double, longitude: Double)

    var method: HTTPMethod { return .get }
    var path: String {
        switch self {
        case .location(let latitude, let longitude):
            var retEndpoint = "current.json?" + "q="
            retEndpoint += String(latitude)
            retEndpoint += ","
            retEndpoint += String(longitude)
            retEndpoint += "&key=" + apiKey
            return retEndpoint
        }
    }
    var parameters: Codable? { return .none }
}
let request = CurrentWeatherRequest.location(latitude: 19.409079, longitude: -99.176728)
Network.jsonRequest(request) { (result) in
    debugPrint(result)
}
PlaygroundPage.current.needsIndefiniteExecution = true
