//
//  NoInternetViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 06/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit
import Reachability

class NoInternetViewController: UIViewController, NetworkStatusListener {
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReachabilityManager.shared.addListener(listener: self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.removeListener(listener: self)
    }
    
    func networkStatusDidChange(status: Reachability.Connection) {
        switch status {
        case .none:
            debugPrint("ViewController: Network became unreachable")
        case .wifi, .cellular:
            self.dismiss(animated: true, completion: nil)
        }
    }
}
