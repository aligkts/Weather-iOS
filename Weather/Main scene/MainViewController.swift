//
//  ViewController.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewDelegate {
 
    @IBOutlet weak var progressLayout: UIView!
    @IBOutlet weak var labelCurrentLocationName: UILabel!
    @IBOutlet weak var labelCurrentLocationTemp: UILabel!
    @IBOutlet weak var imgCurrentWeatherIcon: UIImageView!
    @IBOutlet weak var imgQuestionMark: UIImageView!
    @IBOutlet weak var imgSettings: UIImageView!
    @IBOutlet weak var btnAddLocation: UIButton!
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let mainPresenter = MainPresenter()
    private let locationManager = LocationManager()
    var favoritesList: [WeatherResponse] = []
    var filteredFavoritesList: [WeatherResponse] = []
    var model: WeatherResponse?
    var localWeatherModel: WeatherResponse?
    var requested: Bool = false
    @objc let dataManager: DataManager = DataManager.sharedInstance
    var positionObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        if checkLanguageIsTurkish() {
            API.deviceLanguage = Constant.turkish
        } else {
            API.deviceLanguage = Constant.english
        }
        mainPresenter.setViewDelegate(mainViewDelegate: self)
        locationManager.setViewDelegate(mainViewDelegate: self)
        locationManager.checkLocationServices()
        mainPresenter.getResults()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        let tapGestureRecognizerInfo = UITapGestureRecognizer(target: self, action: #selector(infoTapped(tapGestureRecognizerInfo:)))
        imgQuestionMark.isUserInteractionEnabled = true
        imgQuestionMark.addGestureRecognizer(tapGestureRecognizerInfo)
        let tapGestureRecognizerSettings = UITapGestureRecognizer(target: self, action: #selector(settingsTapped(tapGestureRecognizerSettings:)))
        imgSettings.isUserInteractionEnabled = true
        imgSettings.addGestureRecognizer(tapGestureRecognizerSettings)
        imgSettings.isUserInteractionEnabled = true
        positionObservation = dataManager.observe(\.position, options: [.new, .old, .initial, .prior]) { (vc, change) in
            self.mainPresenter.getResults()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if requested == false, let  localModel = localWeatherModel {
            setCurrentUiComponents(modelResponse: localModel)
        }
    }
    
    @objc func loadList() {
        mainPresenter.getResults()
    }
    
    @objc func infoTapped(tapGestureRecognizerInfo: UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func settingsTapped(tapGestureRecognizerSettings: UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setListToTableView(model: [WeatherResponse]) {
        favoritesList = model
        filteredFavoritesList = favoritesList
        favoritesTableView.reloadData()
    }

    func foundCurrentLocation(latitude: (Double), longitude: (Double)) {
        mainPresenter.makeApiRequest(latitude: latitude, longitude: longitude)
    }
    
    func setCurrentUiComponents(modelResponse: WeatherResponse) {
        localWeatherModel = modelResponse
        self.progressLayout.isHidden = true
        self.labelCurrentLocationName.text = modelResponse.name
        if let tempDouble = modelResponse.main?.temp {
            let selectedUnitType = UserDefaults.standard.string(forKey: "unitType") ?? Constant.metric
            if selectedUnitType == Constant.metric {
                self.labelCurrentLocationTemp.text = "\(tempDouble.removeDecimal())" + "°"
            } else if selectedUnitType == Constant.imperial {
                self.labelCurrentLocationTemp.text = tempDouble.removeDecimal().temperatureToFahrenheit()
            }
        }
        if let iconCode: String = modelResponse.weather?.first?.icon {
            imgCurrentWeatherIcon.imageFromIconCode(iconCode: iconCode)
        }
        if UserDefaults.standard.string(forKey: "ratingStatus") ?? "" != "RatedBefore" {
            RatingAlertView.instance.showAlert()
        }
    }
    
    @IBAction func navigateAddLocation(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddLocationViewController") as? AddLocationViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func permissionDenied() {
       navigateToPermissionDenied()
    }
    
    private func navigateToPermissionDenied () {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "PermissionDeniedViewController") as? PermissionDeniedViewController else { return }
        present(mainNavigationVC, animated: true, completion: nil)
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFavoritesList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteItem = filteredFavoritesList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as? WeatherCell else { return UITableViewCell() }
        cell.setWeatherItem(item: favoriteItem)
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            filteredFavoritesList = favoritesList.filter({
                ($0.name?.lowercased().contains(searchText.lowercased()) ?? false)
            })
        } else {
            filteredFavoritesList = favoritesList
        }
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let weatherResponse: WeatherResponse = filteredFavoritesList[indexPath.row]
            if let favoriteLocation = weatherResponse.favoriteLocation {
                PersistentService.deleteItem(location: favoriteLocation)
            }
            favoritesList.removeAll { (testResponse: WeatherResponse) -> Bool in
                return (testResponse == weatherResponse)
            }
            filteredFavoritesList.remove(at: indexPath.row)
        }
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model = favoritesList[indexPath.row]
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionation = segue.destination as? DetailViewController {
            destionation.model = model
            favoritesTableView.deselectRow(at: favoritesTableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
}
