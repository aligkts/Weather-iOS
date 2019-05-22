//
//  ViewController.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , MainViewDelegate {
    
    @IBOutlet weak var progressLayout: UIView!
    @IBOutlet weak var labelCurrentLocationName:UILabel!
    @IBOutlet weak var labelCurrentLocationTemp: UILabel!
    @IBOutlet weak var imgCurrentWeatherIcon: UIImageView!
    @IBOutlet weak var btnAddLocation: UIButton!
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let mainPresenter = MainPresenter()
    private let locationManager = LocationManager()
    var favoritesList: [WeatherResponse] = []
    var filteredFavoritesList: [WeatherResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesList.removeAll()
        mainPresenter.setViewDelegate(mainViewDelegate: self)
        locationManager.setViewDelegate(mainViewDelegate: self)
        locationManager.checkLocationServices()
        mainPresenter.getFavoritesFromCoreData()
    }
    
    func favoritesRequestResult(model: WeatherResponse) {
        favoritesList.append(model)
        if favoritesList.count == mainPresenter.favoriteLocationList.count {
            filteredFavoritesList = favoritesList
            favoritesTableView.reloadData()
        }
    }
    
    func foundCurrentLocation(latitude: (Double), longitude: (Double)) {
        mainPresenter.makeApiRequest(latitude: latitude, longitude: longitude)
    }
    
    func setCurrentUiComponents(modelResponse: [WeatherResponse]) {
        self.progressLayout.isHidden = true
        self.labelCurrentLocationName.text = modelResponse[0].name
        let temperature = String(describing: modelResponse[0].main?.value(forKey: "temp") ?? "")
        let tempValue = (temperature as NSString).integerValue
        self.labelCurrentLocationTemp.text = "\(tempValue)°"
        if let iconCode: String = modelResponse[0].weather?.first?.value(forKey: "icon") as? String {
            imgCurrentWeatherIcon.imageFromIconCode(iconCode: iconCode)
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
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "PermissionDeniedViewController") as? PermissionDeniedViewController else {
            return
        }
        present(mainNavigationVC,animated: true, completion: nil)
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
        if indexPath.section == 0 {
            let favoriteItem = filteredFavoritesList[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
            cell.setWeatherItem(item: favoriteItem)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFavoritesList = favoritesList
        if searchText.isEmpty == false {
            filteredFavoritesList = favoritesList.filter({($0.name?.lowercased().contains(searchText.lowercased()))!})
        }
        favoritesTableView.reloadData()
    }

}
