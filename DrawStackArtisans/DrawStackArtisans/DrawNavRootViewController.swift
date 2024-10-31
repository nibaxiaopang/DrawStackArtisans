//
//  ViewController.swift
//  DrawStackArtisans
//
//  Created by DrawStackArtisans on 2024/10/31.
//

import UIKit
import Reachability
import Adjust

class DrawNavRootViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.activityIndicator.hidesWhenStopped = true
        drawLoadAdsData()
    }

    private func drawLoadAdsData() {
        guard needShowBannerDescView() else {
            return
        }
                
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        if reachability.connection == .unavailable {
            reachability.whenReachable = { reachability in
                self.reachability.stopNotifier()
                self.drawRequestAdsData()
            }

            reachability.whenUnreachable = { _ in
            }

            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        } else {
            self.drawRequestAdsData()
        }
    }
    
    private func drawRequestAdsData() {
        self.activityIndicator.startAnimating()
        
        guard let bundleId = Bundle.main.bundleIdentifier else {
            return
        }
        
        let url = URL(string: "https://ope\(self.drawMainHostName())/open/postMyDeviceData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "appModelName": UIDevice.current.model,
            "appKey": "9188728e9ff6444e974eb3817c23afbf",
            "appPackageId": bundleId,
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    self.activityIndicator.stopAnimating()
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        let dictionary: [String: Any]? = resDic["data"] as? Dictionary
                        if let dataDic = dictionary {
                            if let adsData = dataDic["jsonObject"] as? [String: Any], let bannData = adsData["bannerData"] as? String {
                                self.drawShowBannerDescView(bnUrl: bannData)
                                return
                            }
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    self.activityIndicator.stopAnimating()
                } catch {
                    print("Failed to parse JSON:", error)
                    self.activityIndicator.stopAnimating()
                }
            }
        }

        task.resume()
    }
    
    private func drawShowBannerDescView(bnUrl: String) {
        let vc: DrawPrivacyViewController = self.storyboard?.instantiateViewController(withIdentifier: "DrawPrivacyViewController") as! DrawPrivacyViewController
        vc.modalPresentationStyle = .fullScreen
        vc.url = bnUrl
        self.navigationController?.present(vc, animated: false)
    }
}

