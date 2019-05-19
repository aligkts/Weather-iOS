//
//  ViewController.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , MainViewDelegate {
   
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
        self.labelCurrentLocationName.text = modelResponse[0].name
        if let temperature: String = "\(String(describing: modelResponse[0].main?.value(forKey: "temp")))" {
            print(temperature)
        }
//        let temperature = "\(String(describing: modelResponse[0].main?.value(forKey: "temp")))"
//        self.labelCurrentLocationTemp.text = "\(temperature)\u{00B0}"
        if let deneme: String = modelResponse[0].weather?.first?.value(forKey: "icon") as? String {
            let iconUrl = URL(string: "\(Constants.API_IMAGE_BASE_URL)\(deneme).png")
            downloadImage(from: iconUrl!)
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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imgCurrentWeatherIcon.image = UIImage(data: data)
            }
        }
    }

}

