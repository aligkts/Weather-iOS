//
//  ViewController.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , MainViewDelegate{
   
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
        print(latitude)
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
    
    @IBAction func openAddLocation(_ sender: UIButton) {
      
    }
    
}

