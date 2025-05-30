//
//  AppDelegate.swift
//  Glenroe-Ballyorgan
//
//  Created by Liya Wang on 2024/7/25.
//

import UIKit
import CoreLocation
import FirebaseCore
import GoogleSignIn
import Firebase 
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Location services to be available throughout the app
    var window: UIWindow?
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        Thread.sleep(forTimeInterval: 1.0)  
//        
        
            FirebaseApp.configure()
        let db = Firestore.firestore()
 
        
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // Handle the Google Sign-In callback
        return GIDSignIn.sharedInstance.handle(url)
    }
}


