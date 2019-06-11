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
    @IBOutlet weak var btnAddLocation: UIButton!
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let mainPresenter = MainPresenter()
    private let locationManager = LocationManager()
    var favoritesList: [WeatherResponse] = []
    var filteredFavoritesList: [WeatherResponse] = []
    var model: WeatherResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        mainPresenter.setViewDelegate(mainViewDelegate: self)
        locationManager.setViewDelegate(mainViewDelegate: self)
        locationManager.checkLocationServices()
        mainPresenter.getResults()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList() {
        mainPresenter.getResults()
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
        self.progressLayout.isHidden = true
        self.labelCurrentLocationName.text = modelResponse.name
        if let tempDouble = modelResponse.main?.temp {
            self.labelCurrentLocationTemp.text = "\(tempDouble.removeDecimal())"+"°"
        }
        if let iconCode: String = modelResponse.weather?.first?.icon {
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
        if searchText.isEmpty {
            mainPresenter.getResults()
        }
        if searchText.isEmpty == false {
            filteredFavoritesList = favoritesList.filter({
                ($0.name?.lowercased().contains(searchText.lowercased()) ?? false)
            })
        }
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let id = filteredFavoritesList[indexPath.row].uuid {
                PersistentService.deleteItem(id: id)
                filteredFavoritesList.remove(at: indexPath.row)
                if let text = searchBar.text {
                    if text.isEmpty {
                        favoritesList = filteredFavoritesList
                    }
                }
            }
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
