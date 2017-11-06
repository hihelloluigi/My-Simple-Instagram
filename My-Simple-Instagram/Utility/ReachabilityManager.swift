//
//  Reachability.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Reachability

/// Protocol for listenig network status change
public protocol NetworkStatusListener : class {
    func networkStatusDidChange(status: Reachability.Connection)
}

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    
    //MARK:- Variables
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .none
    }
    var reachabilityStatus: Reachability.Connection = .none
    let reachability = Reachability()!
    var listeners = [NetworkStatusListener]()
    
    /**
     Called whenever there is a change in NetworkReachibility Status
        — parameter notification: Notification with the Reachability instance
     */
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        
        switch reachability.connection {
        case .none:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
        }
        
        // Sending message to each of the delegates
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.connection)
        }
    }
    
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged(notification:)),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }
    
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    
    
    /**
     Adds a new listener to the listeners array
        - parameter delegate: a new listener
     */
    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
    }
    
    /**
     Removes a listener from listeners array
     - parameter delegate: the listener which is to be removed
     */
    func removeListener(listener: NetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }
}
