//
//  LocationManager.swift
//  ShinyDay
//
//  Created by YoonieMac on 6/4/25.
//

import UIKit
import CoreLocation

public class LocationManager: NSObject {
    let manager: CLLocationManager
    
    public var location: CLLocation?
    public var locationName: String?
    public let api = WeatherApi()
    public var backgroundImage: UIImage?
    
    //  CLLocation은 전체로 UserDefault에 저장할 수 없음(객체 힘듦) 그래서 위도 경도를 나눠서 저장해야 함
    public var lastLocation: CLLocation? {
        get {
            guard let lat = UserDefaults.standard.object(forKey: "lastLocationLat") as? CLLocationDegrees,
                  let lon = UserDefaults.standard.object(forKey: "lastLocationLon") as? CLLocationDegrees else {return nil}
            return CLLocation(latitude: lat, longitude: lon)
        }
        set {
            UserDefaults.standard.set(newValue?.coordinate.latitude, forKey: "lastLocationLat")
            UserDefaults.standard.set(newValue?.coordinate.longitude, forKey: "lastLocationLon")
        }
    }
    
    public override init() {
        
        manager = CLLocationManager()
        
        manager.distanceFilter = 1000
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        guard let savedLocation = lastLocation else {return}
        locationUpdate(currentLocation: savedLocation)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
//            manager.requestLocation() // 베터리 절약
            manager.startUpdatingLocation()
        default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        let error = error as NSError
        guard error.code == CLError.Code.locationUnknown.rawValue else {return}
        print(error.code)
        manager.stopUpdatingLocation()
    }
    
    func locationUpdate(currentLocation: CLLocation) {
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
        
        locationUpdate(currentLocation: currentLocation)
        lastLocation = currentLocation

    }
    
    func updateLocationName(location: CLLocation) async {
        do {
            
            let geocoder = CLGeocoder()
            let placemarks = try await geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ko_kr"))
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
        }
    }
}

public extension Notification.Name {
    static let weatherDataDidFetch = Notification.Name("weatherDataDidFetch")
    // MARK: noti 추가해야 함
    static let backgroundImageDidDownload = Notification.Name("backgroundImageDidDownload")
    static let locationNameDidUpdate = Notification.Name("locationNameDidUpdate")
}
