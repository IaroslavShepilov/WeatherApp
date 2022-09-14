//
//  MainViewController.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 21.07.2022.
//

import UIKit
import CoreLocation
import Kingfisher

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet private var mainView: UIView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var collectionView: UICollectionView!
    
    @IBOutlet weak var mainWeatherView: MainWeatherView!
    private var viewModel = MainViewModel()
    
    let locationManager = CLLocationManager()
    let screenSize = UIScreen.main.bounds
    var myStructVar: MyStruct?
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.register(UINib.init(nibName: "CustomCellForOtherDayWeather", bundle: nil), forCellReuseIdentifier: "reuseIdentifierOtherDay")
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionReusableCell")
        mainWeatherView.chooseLocationButton.addTarget(self, action: #selector(didTapchooseLocationButton), for: .touchUpInside)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func didTapchooseLocationButton() {
        let vc = FindCityViewController(nibName: "FindCityViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - LocationSetup -
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
}
        let lon = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
//        let lon = 122.0321800
//        let lat = 37.3230000
        viewModel.getWeather(lat: lat, lon: lon)
    }
    // MARK: - TableViewSetup -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStructVar?.thirdBlockInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCellForOtherDayWeather = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifierOtherDay", for: indexPath) as! CustomCellForOtherDayWeather
        if let data: ThirdBlock = myStructVar?.thirdBlockInfo[indexPath.row] {
            cell.setupCustomCell(data)
        }
//        if let data: FirstBlock = myStructVar?.firstBlockInfo[indexPath.row] {
//            let currentDay = viewModel.getDayForDate(Date(timeIntervalSince1970: Double(data.dateString) ?? 1970))
//            customView.setupView(cityName: data.cityName, currentDay: currentDay, weatherIconId: data.weatherId, temp: data.temp, wind: data.speed, humidity: data.humidity)
//            viewModel.setupWeatherImage(weatherId: data.weatherId, image: customView.weatherImage)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data: FirstBlock = myStructVar?.firstBlockInfo[indexPath.row] {
            let currentDay = viewModel.getDayForDate(Date(timeIntervalSince1970: Double(data.dateString) ?? 1970))
            mainWeatherView.setupView(cityName: data.cityName, currentDay: currentDay, weatherIconId: data.weatherId, temp: data.temp, wind: data.speed, humidity: data.humidity)
            viewModel.setupWeatherImage(weatherId: data.weatherId, image: mainWeatherView.weatherImage)
        }
    }
    // MARK: - CollectionViewSetup -

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myStructVar?.secondBlockInfo.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionReusableCell", for: indexPath) as! CollectionViewCell
        if let data: SecondBlock = myStructVar?.secondBlockInfo[indexPath.row] {
            cell.setup(data)
        }
        return cell
    }
    
    func setupMainView(items: [FirstBlock]) {
        if let element = items.first {
            let cityName = element.cityName
            let temp = element.temp
            let wind = element.speed
            let humidity = element.humidity
            let weatherIconId = element.weatherId
            let currentDay = viewModel.getDayForDate(Date(timeIntervalSince1970: Double(element.dateString) ?? 1970))
            viewModel.setupWeatherImage(weatherId: element.weatherId, image: mainWeatherView.weatherImage)
            mainWeatherView.setupView(cityName: cityName, currentDay: currentDay, weatherIconId: weatherIconId, temp: temp, wind: wind, humidity: humidity)
        }
    }
}
    // MARK: - Extensions -
extension MainViewController: MainViewModelProtocol {
    func updateWeatherInfo(response: MyStruct) {
        myStructVar = response
        setupMainView(items: response.firstBlockInfo)
        tableView.reloadData()
        collectionView.reloadData()
    }
}

