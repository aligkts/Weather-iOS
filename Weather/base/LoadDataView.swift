//
//  LoadDataView.swift
//  Weather
//
//  Created by Ali Goktas on 16.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import UIKit

protocol LoadDataView: BaseView {
    func showLoading()
    func hideLoading();
    func showRetry();
    func hideRetry();
}
