//
//  AppDelegate.swift
//  TabsViewUIKit
//
//  Created by Mohamed Korany on 6/23/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
        configureNavigationBarAppearance()
        
        let tabsController = getTabsController()
        window?.rootViewController = UINavigationController(rootViewController: tabsController)
        return true
    }
    
}

// MARK: - Configuration
//
private extension AppDelegate {
    
    func configureNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = .tab
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
    
    func getTabsController() -> PageViewController {
        let chatViewController = ChatViewController()
        chatViewController.tabBarItem = UITabBarItem(title: "Chat", image: .chatIcon)
        
        let statusViewController = StatusViewController()
        statusViewController.tabBarItem = UITabBarItem(title: "Status",image: .statusIcon)
        
        let callsViewController = CallsViewController()
        callsViewController.tabBarItem = UITabBarItem(title: "Calls",image: .callIcon)
        
        let tabController = PageViewController()
        tabController.title = "Tabs View UIKit"
        tabController.applyDefaultStyle()
        tabController.controllers = [chatViewController, statusViewController, callsViewController]
        
        return tabController
    }
}

// MARK: - UITabBarItem+Heleprs
//
extension UITabBarItem {
    
    /// Convenience init using title only, settings image and tag with null values
    ///
    convenience init(title: String, image: UIImage?) {
        self.init(title: title, image: image, selectedImage: nil)
    }
}
