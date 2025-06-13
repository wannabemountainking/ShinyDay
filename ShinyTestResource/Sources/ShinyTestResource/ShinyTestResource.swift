import Foundation


public struct ShinyTestResource {
    private init() {}
    
    public struct JsonData {
        public static var currentWeather: Data {
            let url = Bundle.module.url(forResource: "CurrentWeather", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
        public static var forecast: Data {
            let url = Bundle.module.url(forResource: "Forecast", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
        public static var airPollution: Data {
            let url = Bundle.module.url(forResource: "AirPollution", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
        public static var reverseGeocoding: Data {
            let url = Bundle.module.url(forResource: "ReverseGeocoding", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
        public static var randomImage: Data {
            let url = Bundle.module.url(forResource: "RandomImage", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
    }
    
    public struct JsonString {
        public static var currentWeather: String {
            return String(data: JsonData.currentWeather, encoding: .utf8)!
        }
        public static var forecast: String {
            return String(data: JsonData.forecast, encoding: .utf8)!
        }
        public static var airPollution: String {
            return String(data: JsonData.airPollution, encoding: .utf8)!
        }
        public static var reverseGeocoding: String {
            return String(data: JsonData.reverseGeocoding, encoding: .utf8)!
        }
        public static var randomImage: String {
            return String(data: JsonData.randomImage, encoding: .utf8)!
        }
    }
}

