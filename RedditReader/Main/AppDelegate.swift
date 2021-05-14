//
//  AppDelegate.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var networkManager: NetworkManagerProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard let baseURL = Bundle.baseURL else {
            preconditionFailure("Failed to retrieve base url from Info.plist file")
        }
        self.networkManager = HTTPNetworkManager(baseURL: baseURL)
        return true
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

extension AppDelegate {
    
    static var sharedNetworkManager: NetworkManagerProtocol? {
        guard let appDelegate = UIApplication.shared.delegate as? Self else {
            return nil
        }
        return appDelegate.networkManager
    }
    
}
