import Foundation

let apiKey = "6e1272c89227425c890161300181012"

public enum CurrentWeatherRequest: NetworkRequest {
    case location(latitude: Double, longitude: Double)

    public var method: HTTPMethod { return .get }
    public var path: String {
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
    public var parameters: Codable? { return .none }
}
