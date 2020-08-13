//
//  SceneDelegate.swift
//  mTube
//
//  Created by DNA-Z on 6/26/20.
//  Copyright © 2020 DNA-Z. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let layout = UICollectionViewFlowLayout()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: createTabBar())
        window?.makeKeyAndVisible()
        
    }
    
    func createTabBar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .blue
//        tabbar.viewControllers = [createHomeNavigationController(),createExploreNavigationController(),createUserProfileNavigationController()]
        tabbar.viewControllers = createController()
                  //setup the navigation bar from  createTabBar
                  let titleImageView = UIImageView()
                  titleImageView.image = UIImage(named: "user")
                  titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                  titleImageView.contentMode = .scaleAspectFit
                  let leftnavbtn = UIButton(type: .system)
                  leftnavbtn.setImage(UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), for: .normal)
                  leftnavbtn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                  let searchbtn = UIButton(type: .system)
                  searchbtn.setImage(UIImage(named: "subs")?.withRenderingMode(.alwaysOriginal), for: .normal)
                  searchbtn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                  let librarybtn = UIButton(type: .system)
                  librarybtn.setImage(UIImage(named: "library")?.withRenderingMode(.alwaysOriginal), for: .normal)
                  librarybtn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                  tabbar.navigationItem.titleView = titleImageView
                  tabbar.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftnavbtn)
                  tabbar.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: searchbtn),UIBarButtonItem(customView: librarybtn)]
        
        return tabbar
    }
    
    func createController() ->[UIViewController] {
           let controllers = [HomeViewController(collectionViewLayout: layout),ExploreVC(),UserProfileVC()]
           let title = ["Home","Explore","User"]
            for (titleindex,controller) in controllers.enumerated() {
            controller.tabBarItem.title = title[titleindex]
            controller.tabBarItem.image = UIImage(named: title[titleindex].lowercased())}
           return controllers
       }
    
//    func createHomeNavigationController() -> UIViewController {
//        let homeVC = HomeViewController(collectionViewLayout: layout)
//        homeVC.tabBarItem.title = "Home"
//        homeVC.tabBarItem.image = UIImage(named: "home")
//        return homeVC
//    }
//    func createExploreNavigationController() ->UIViewController {
//        let exploreVC = ExploreVC()
//        exploreVC.tabBarItem.title = "Explore"
//        exploreVC.tabBarItem.image = UIImage(named: "explore")
//        return exploreVC
//    }
//
//
//    func createUserProfileNavigationController() ->UIViewController {
//        let userProfileVC = UserProfileVC()
//        userProfileVC.tabBarItem.title = "User"
//        userProfileVC.tabBarItem.image = UIImage(named: "userprofile")
//        return userProfileVC
//
//    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("didDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("didBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("ResignActive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("EnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("EnterBackgroud")
    }


}


