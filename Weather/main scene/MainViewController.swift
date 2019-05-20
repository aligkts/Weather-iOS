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

    override func viewDidLoad() {
        super.viewDidLoad()
        mainPresenter.setViewDelegate(mainViewDelegate: self)
        locationManager.setViewDelegate(mainViewDelegate: self)
        locationManager.checkLocationServices()
    }
    
    func foundCurrentLocation(latitude: (Double), longitude: (Double)) {
        mainPresenter.makeApiRequest(latitude: latitude, longitude: longitude)
    }
    
    func setCurrentUiComponents(modelResponse: [WeatherResponse]) {
        self.progressLayout.isHidden = true
        self.labelCurrentLocationName.text = modelResponse[0].name
        if let temperature: String = String(describing: modelResponse[0].main?.value(forKey: "temp") ?? "") {
            let tempValue = (temperature as NSString).integerValue
            self.labelCurrentLocationTemp.text = "\(tempValue)\u{00B0}"
        }
        if let iconCode: String = modelResponse[0].weather?.first?.value(forKey: "icon") as? String {
            mainPresenter.downloadImageFromIconCode(iconCode: iconCode)
        }
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
    
    func iconDownloadedFromIconCode(data: Data) {
        self.imgCurrentWeatherIcon.image = UIImage(data: data)
    }
    
    

}

