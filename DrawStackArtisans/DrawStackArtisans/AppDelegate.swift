//
//  AppDelegate.swift
//  DrawStackArtisans
//
//  Created by jin fu on 2024/10/31.
//

import UIKit
import IQKeyboardManagerSwift

func sandboxArchivePath() -> String {
    let dir : NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    let path = dir.appendingPathComponent("solitaireGame.plist")
    return path
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var solitaire : DrawSolitaire!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initConfig()
        return true
    }
    
    func initConfig() {
        let archiveName = sandboxArchivePath()
        if FileManager.default.fileExists(atPath: archiveName) {
            let dict = NSDictionary(contentsOfFile: archiveName) as! [String : AnyObject]
            solitaire = DrawSolitaire(dictionary: dict)
        } else {
            solitaire = DrawSolitaire()
            solitaire.freshGame()
        }
        IQKeyboardManager.shared.enable = true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

