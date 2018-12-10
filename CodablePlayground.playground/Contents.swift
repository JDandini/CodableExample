import UIKit
import PlaygroundSupport

struct Location: Codable {
    let country: String?
    let latitude: Double?
    let longitude: Double?
    let name: String?
    let time: String?
    let region: String?

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case latitude = "lat"
        case longitude = "lon"
        case name = "name"
        case time = "localtime"
        case region = "region"
    }
}

struct WeatherCondition: Codable {
    let code: Int?
    let icon: String?
    let text: String?
}

struct Weather: Codable {
    let cloudPercent: Int?
    let condition: WeatherCondition?
    let senseCelsius: Double?
    let senseFahrenheit: Double?
    let humidity: Int?
    let isDayTime: Int?
    let lastUpdated: String?
    let temperatureCelsius: Double?
    let temperatureFahrenheit: Double?
    let windKmPH: Double?
    let windMPH: Double?
    let precipitationInch: Double?
    let precipitationMilimiters: Double?


    enum CodingKeys: String, CodingKey {
        case cloudPercent = "cloud"
        case condition = "condition"
        case senseCelsius = "feelslike_c"
        case senseFahrenheit = "feelslike_f"
        case humidity = "humidity"
        case isDayTime = "is_day"
        case lastUpdated = "last_updated"
        case precipitationInch = "precip_in"
        case precipitationMilimiters = "precip_mm"
        case temperatureCelsius = "temp_c"
        case temperatureFahrenheit = "temp_f"
        case windKmPH = "wind_kph"
        case windMPH = "wind_mph"
    }
}

struct CurrentWeather: Codable {
    let location: Location?
    let weather: Weather?

    enum CodingKeys: String, CodingKey {
        case location = "location"
        case weather = "current"
    }
}

let request = CurrentWeatherRequest.location(latitude: 19.409079, longitude: -99.176728)
Network.performRequest(request) { (result: Result<CurrentWeather>) in
    switch result {
    case .success(let weather):
        print("Weather downloaded")
        dump(weather)
    case .failure(let error):
        print(error.localizedDescription)
    }
}
PlaygroundPage.current.needsIndefiniteExecution = true
