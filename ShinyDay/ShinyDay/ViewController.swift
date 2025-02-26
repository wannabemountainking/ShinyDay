//
//  ViewController.swift
//  ShinyDay
//
//  Created by yoonie on 2/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    let api = WeatherApi()
    
    var topInset: CGFloat = 0.0

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.fetch(lat: 37.571449, lon: 127.021375) { [weak self] in
            guard let self else {return}
            self.weatherCollectionView.reloadData()
        }
        weatherCollectionView.backgroundColor = .clear
        weatherCollectionView.showsHorizontalScrollIndicator = false
        setupLayout()
    }
    
    func setupLayout() {
        let summaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180))
        let summaryItem = NSCollectionLayoutItem(layoutSize: summaryItemSize)
        let summaryGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180))
        let summaryGroup = NSCollectionLayoutGroup.horizontal(layoutSize: summaryGroupSize, subitems: [summaryItem])
        let summarySection = NSCollectionLayoutSection(group: summaryGroup)
        summarySection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let forecastItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let forecastItem = NSCollectionLayoutItem(layoutSize: forecastItemSize)
        let forecastGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let forecastGroup = NSCollectionLayoutGroup.horizontal(layoutSize: forecastGroupSize, subitems: [forecastItem])
        let forecastSection = NSCollectionLayoutSection(group: forecastGroup)
        forecastSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        forecastSection.interGroupSpacing = 8
        
        let detailItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
        let detailItem = NSCollectionLayoutItem(layoutSize: detailItemSize)
        let detailGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
        let detailGroup = NSCollectionLayoutGroup.horizontal(layoutSize: detailGroupSize, subitems: [detailItem])
        detailGroup.interItemSpacing = .flexible(10)
        let detailSection = NSCollectionLayoutSection(group: detailGroup)
        detailSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        detailSection.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            switch sectionIndex {
            case 0:
                return summarySection
            case 1:
                return forecastSection
            default:
                return detailSection
            }
        }
        weatherCollectionView.collectionViewLayout = layout
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard topInset == 0.0 else {return}
        let first = IndexPath(item: 0, section: 0)
        guard let cell = weatherCollectionView.cellForItem(at: first) else {return}
        
        topInset = weatherCollectionView.frame.height - cell.frame.height - weatherCollectionView.safeAreaInsets.bottom - 20
        
        var inset = weatherCollectionView.contentInset
        inset.top = topInset
        weatherCollectionView.contentInset = inset
        
        weatherCollectionView.selectItem(at: first, animated: false, scrollPosition: .bottom)
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return api.forecastList.count // 일기예보 갯수
        case 2:
            return api.detailInfo.count // 부가정보 갯수
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
                cell.minMaxLabel.text = "최고 \(main.tempMax.temperatureString)  최저 \(main.tempMin.temperatureString)"
                cell.currentTemperatureLabel.text = "\(main.temp.temperatureString)"
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
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailInfoCollectionViewCell.self), for: indexPath) as! DetailInfoCollectionViewCell
            let target = api.detailInfo[indexPath.item]
            cell.imageView.image = target.image
            cell.titleLabel.text = target.title
            cell.valueLabel.text = target.value
            cell.descriptionLabel.text = target.description
            return cell
        default:
            fatalError()
        }
    }
    
    
}
