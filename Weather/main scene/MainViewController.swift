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
    private let mainPresenter = MainPresenter()
    private let locationManager = LocationManager()
    var favoritesListResultFromApi: [WeatherResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesListResultFromApi.removeAll()
        mainPresenter.setViewDelegate(mainViewDelegate: self)
        locationManager.setViewDelegate(mainViewDelegate: self)
        locationManager.checkLocationServices()
        mainPresenter.getFavoritesFromCoreData()
    }
    
    func favoritesRequestResult(model: WeatherResponse) {
        favoritesListResultFromApi.append(model)
        if favoritesListResultFromApi.count == mainPresenter.favoriteEntity.count {
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

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesListResultFromApi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteItem = favoritesListResultFromApi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        cell.setWeatherItem(item: favoriteItem)
        return cell
    }

}
