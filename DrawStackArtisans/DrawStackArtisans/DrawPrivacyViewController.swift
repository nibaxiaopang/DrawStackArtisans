//
//  PrivacyViewController.swift
//  DrawStackArtisans
//
//  Created by jin fu on 2024/10/31.
//

import UIKit
import WebKit
import Adjust

class DrawPrivacyViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {

    //MARK: - Declare IBOutlets
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indView: UIActivityIndicatorView!
    
    //MARK: - Declare Variables
    var url: String?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    //MARK: - Declare IBAction
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.backBtn.isHidden = self.url != nil
        self.indView.hidesWhenStopped = true
        
        initWebView()
    }
    
    func initWebView() {
        self.webView.backgroundColor = .black
        self.webView.scrollView.backgroundColor = .black
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        
        let userContentC = self.webView.configuration.userContentController
        let trackStr = """
        window.jsBridge = {
            openBrower: function(data) {
                window.webkit.messageHandlers.DrawPrivacyHandleName.postMessage(data)
            }
        };
        window.Adjust = {
            trackEvent: function(data) {
                window.webkit.messageHandlers.DrawPrivacyEVName.postMessage(data)
            }
        };
        """
        let trackScript = WKUserScript(source: trackStr, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        userContentC.addUserScript(trackScript)
        userContentC.add(self, name: "DrawPrivacyHandleName")
        userContentC.add(self, name: "DrawPrivacyEVName")
        
        self.indView.startAnimating()
        if let adurl = url {
            if let urlRequest = URL(string: adurl) {
                let request = URLRequest(url: urlRequest)
                webView.load(request)
            }
        } else {
            if let urlRequest = URL(string: "https://www.termsfeed.com/live/41890b78-9203-44f0-9f29-325e6e4a5b2a") {
                let request = URLRequest(url: urlRequest)
                webView.load(request)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.indView.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.indView.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            if let url = navigationAction.request.url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        return nil
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "DrawPrivacyHandleName" {
            if let data = message.body as? String {
                if let url = URL(string: data) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        } else if message.name == "DrawPrivacyEVName" {
            if let data = message.body as? [String : Any] {
                print("DrawPrivacyEVName: \(data)")
                if let evTok = data["eventToken"] as? String, !evTok.isEmpty {
                    Adjust.trackEvent(ADJEvent(eventToken: evTok))
                }
            }
        }
    }
}
