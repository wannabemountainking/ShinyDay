//
//  LocationManager.swift
//  ShinyDay
//
//  Created by YoonieMac on 6/4/25.
//

import UIKit
import CoreLocation

public protocol LocationManaging: AnyObject {
    var distanceFilter: CLLocationDistance {get set}
    var desiredAccuracy: CLLocationAccuracy {get set}
    var delegate: (any CLLocationManagerDelegate)? {get set}
    var authorizationStatus: CLAuthorizationStatus {get}
    
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
}

public protocol Geocodable {
    func reverseGeocodeLocation(_ location: CLLocation, preferredLocale locale: Locale?) async throws -> [PlacemarkType]
}

extension CLGeocoder: Geocodable {
    public func reverseGeocodeLocation(_ location: CLLocation, preferredLocale locale: Locale?) async throws -> [PlacemarkType] {
        let list: [CLPlacemark] = try await reverseGeocodeLocation(location, preferredLocale: locale)
        return list as [PlacemarkType]
    }
}

extension CLLocationManager: LocationManaging {}

public class LocationManager: NSObject, @unchecked Sendable {
    let manager: LocationManaging
    private let userDefaults: UserDefaults
    private let geocoder: Geocodable
    
    public var location: CLLocation?
    public var locationName: String?
    public let api = WeatherApi()
    public var backgroundImage: UIImage?
    
    //  CLLocation은 전체로 UserDefault에 저장할 수 없음(객체 힘듦) 그래서 위도 경도를 나눠서 저장해야 함
    public var lastLocation: CLLocation? {
        get {
            guard let lat = userDefaults.object(forKey: "lastLocationLat") as? CLLocationDegrees,
                  let lon = userDefaults.object(forKey: "lastLocationLon") as? CLLocationDegrees else {return nil}
            return CLLocation(latitude: lat, longitude: lon)
        }
        set {
            userDefaults.set(newValue?.coordinate.latitude, forKey: "lastLocationLat")
            userDefaults.set(newValue?.coordinate.longitude, forKey: "lastLocationLon")
        }
    }
    
    public init(locationManager: LocationManaging = CLLocationManager(), userDefaults: UserDefaults = .standard, geocoder: Geocodable = CLGeocoder()) {
        
        manager = locationManager
        
        manager.distanceFilter = 1000
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.userDefaults = userDefaults
        self.geocoder = geocoder
        
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        guard let savedLocation = lastLocation else {return}
        update(currentLocation: savedLocation)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways, .authorizedWhenInUse:
//            manager.requestLocation() // 베터리 절약
            manager.startUpdatingLocation()
        default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        let error = error as NSError
        guard error.code != CLError.Code.locationUnknown.rawValue else {return}
        print(error.code)
        manager.stopUpdatingLocation()
    }
    
    @objc func update(currentLocation: CLLocation) {
        Task {
            await updateLocationName(location: currentLocation)
            NotificationCenter.default.post(name: .locationNameDidUpdate, object: nil)
            
        }
        Task {
            try await api.fetch(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
            
            NotificationCenter.default.post(name: Notification.Name.weatherDataDidFetch, object: nil)
            
        }
        Task {
            let location: String = try await api.fetchLocation(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
            let url: URL = try await api.fetchRandomImage(city: location)
            backgroundImage = try await api.downloadImage(from: url)
            
            NotificationCenter.default.post(name: .backgroundImageDidDownload, object: nil)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            location = currentLocation
            
            Task {
                await updateLocationName(location: currentLocation)
                NotificationCenter.default.post(name: .locationNameDidUpdate, object: nil)
            }
            
            Task {
                try await api.fetch(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
                NotificationCenter.default.post(name: .weatherDataDidFetch, object: nil)
            }
            
            Task {
                let location = try await self.api.fetchLocation(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
                let url = try await self.api.fetchRandomImage(city: location)
                backgroundImage = try await self.api.downloadImage(from: url)
                
                NotificationCenter.default.post(name: .backgroundImageDidDownload, object: nil)
            }
        }
        guard let currentLocation = locations.last else {return}
        location = currentLocation
        
        update(currentLocation: currentLocation)
        lastLocation = currentLocation

    }
    
    func updateLocationName(location: CLLocation) async {
        do {
            // 여기서 reverseGeocodeLocation메서드는 우리가 만든 것이 아니라 프레임워크에서 제공하는 메서드이므로 우리가 만든 것으로 바꿔야 한다. 그 방법읍
            // 위 메서드를 필수로 하는 Geocodable 프로토콜을 만들고,
            // extension으로 CLGeocoder 클래스가 Geocodable 프로토콜을 채택하게 하고(LocationManager의 초기화에 Geocodable을 채택한 CLGeocoder 객체갸 필요함)
            // 또한 StubCLGeocoder도 Geocodable을 채택해서 두 객체의 메서드를 사용할 수 있게 해야 함(만약 StubCLGeocoder가 CLGeocoder를 상속하면 동일한 이름의 메서드가 Geocodable의 필수 구현 메서드와 부합하여 둘 중 어떤 것을 써야 할 지 컴퓨터가 혼동하게 됨)
            // 그러면 LocationManager의 속성인 geocoder의 타입은 StubGeocoder가 되어 geocoder.reverseGeocodeLocation메서드는 우리가 만든 StubCLGeocoder의 메서드를 사용하게됨.
            let placemarks: [PlacemarkType] = try await geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ko_kr"))
            if let place = placemarks.first {
                if let name = place.name {
                    locationName = name
                } else if let locality = place.locality {
                    locationName = "\(locality) \(place.subLocality ?? "")".trimmingCharacters(in: .whitespaces)
                } else {
                    locationName = place.description
                }
            } else {
                locationName = "알 수 없음"
            }
        } catch {
            print(error)
            locationName = "알 수 없음"
        }
    }
}

public extension Notification.Name {
    static let weatherDataDidFetch = Notification.Name("weatherDataDidFetch")
    // MARK: noti 추가해야 함
    static let backgroundImageDidDownload = Notification.Name("backgroundImageDidDownload")
    static let locationNameDidUpdate = Notification.Name("locationNameDidUpdate")
}

public protocol PlacemarkType {
    var name: String? {get}
    var locality: String? {get}
    var subLocality: String? {get}
    var description: String {get}
}

extension CLPlacemark: PlacemarkType {}
