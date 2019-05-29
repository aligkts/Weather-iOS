//
//  TaskManager.swift
//  Weather
//
//  Created by Ali Goktas on 21.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

class TaskManager {
    
    static let shared = TaskManager()
    let session = URLSession(configuration: .default)
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    var tasks = [URL: [completionHandler]]()

    func dataTask(with url: URL, completion: @escaping completionHandler) {
        tasks[url] = [completion]
        let _ = session.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            DispatchQueue.main.sync {
                guard let completionHandlers = self?.tasks[url] else { return }
                for handler in completionHandlers {
                    handler(data, response, error)
                }
            }
        }).resume()
    }
    
}
