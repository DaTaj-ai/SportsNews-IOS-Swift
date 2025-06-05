//
//  NetworkHelper.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 03/06/2025.
//

import Foundation
import Network
import UIKit

class NetworkManager {
    static func isInternetAvailable(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
            monitor.cancel()
        }
        monitor.start(queue: queue)
    }
    static func showNoInternetAlert(on viewController: UIViewController, retryHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your network settings and try again",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        if let retryHandler = retryHandler {
            alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
                retryHandler()
            })
        }
        
        viewController.present(alert, animated: true)
    }
    
    
    }
