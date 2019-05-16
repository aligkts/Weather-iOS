//
//  BasePresenter.swift
//  Weather
//
//  Created by Ali Goktas on 16.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

protocol BasePresenter {
    
    associatedtype View
    
    func attachView(view : View)
    
    func detachView()
    
    func destroy()
    
}
