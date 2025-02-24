//
//  ViewController.swift
//  ShinyDay
//
//  Created by yoonie on 2/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    let api = WeatherApi()

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.fetch(lat: 37.571449, lon: 127.021375) { [weak self] in
            guard let self else {return}
            self.weatherCollectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return api.forecastList.count // 일기예보 갯수
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SummaryCollectionViewCell.self), for: indexPath) as! SummaryCollectionViewCell
            if let weather = api.summary?.weather.first, let main = api.summary?.main {
                cell.weatherImageView.image = UIImage(named: weather.icon)
                cell.statusLabel.text = weather.description
                cell.minMaxLabel.text = "최고 \(main.temp_max.temperatureString)  최저 \(main.temp_min.temperatureString)"
                cell.currentTemperatureLabel.text = "\(main.temp.temperatureString)º"
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ForecastCollectionViewCell.self), for: indexPath) as! ForecastCollectionViewCell
            let target = api.forecastList[indexPath.item]
            cell.dateLabel.text = target.date.dateString
            cell.timeLabel.text = target.date.timeString
            cell.statusLabel.text = target.weatherStatus
            cell.temperatureLabel.text = target.temperature.temperatureString
            cell.weatherImageView.image = UIImage(named: target.icon)
            return cell
        default:
            fatalError()
        }
    }
    
    
}
