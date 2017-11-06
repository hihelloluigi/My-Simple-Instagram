//
//  LoginViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (ReachabilityManager.shared.reachability.connection != .none) {
            setup()
        } else {
            let mainStoryboard = UIStoryboard(name: "Login", bundle: Bundle.main)
            let controller: NoInternetViewController = mainStoryboard.instantiateViewController(withIdentifier: "NoInternetViewController") as! NoInternetViewController
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    // MARK:- Setup
    private func setup() {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [AppConfig.INSTAGRAM_AUTHURL, AppConfig.INSTAGRAM_CLIENT_ID, AppConfig.INSTAGRAM_REDIRECT_URI, AppConfig.INSTAGRAM_SCOPE])
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        webView.delegate = self
        webView.loadRequest(urlRequest)
    }
    
    private func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        //APILOL.INSTAGRAM_REDIRECT_URI
        if requestURLString.hasPrefix(AppConfig.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            let newStr = String(requestURLString[range.upperBound...])
            handleAuth(authToken: newStr)
            return false;
        }
        return true
    }
    private func handleAuth(authToken: String) {
        print("Token: \(authToken)")
        Config.store(token: authToken)
        
        let mainStoryboard = UIStoryboard(name: "Gallery", bundle: Bundle.main)
        let controller: NavigationController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
        self.present(controller, animated: true, completion: nil)
    }
}

// MARK:- WebView Delegate
extension LoginViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request:URLRequest,
                 navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallbackURL(request: request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loginIndicator.isHidden = false
        loginIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loginIndicator.isHidden = true
        loginIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        webViewDidFinishLoad(webView)
    }
}


