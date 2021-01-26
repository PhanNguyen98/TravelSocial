//
//  CustomBarViewController.swift
//  Travel Social
//
//  Created by Phan Nguyen on 22/01/2021.
//

import UIKit
import Photos

class CustomBarViewController: UITabBarController {

    var homeViewController = HomeViewController()
    var searchViewController = SearchViewController()
    var messageViewController = SearchViewController()
    var userViewController = UserViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        checkCamera()
        checkPhotoLibrary()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setTabBar() {
        self.delegate = self
        homeViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        let searchNavigation = UINavigationController(rootViewController: searchViewController)
        messageViewController.tabBarItem.image = UIImage(systemName: "message.fill")
        userViewController.tabBarItem.image = UIImage(systemName: "person.fill")
        viewControllers = [homeViewController, searchNavigation, messageViewController, userViewController]
        tabBar.tintColor = UIColor.black
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
        }
    }
    
    func checkPhotoLibrary() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .authorized:
                    break
                default:
                    DispatchQueue.main.async {
                        UIApplication.shared.open(URL(string: "App-prefs:DemoFruit&path=Photo")!, options: [:], completionHandler: nil)
                    }
                }
            })
        } else if photos == .authorized {
        }
    }
    
    func checkCamera() {
        AVCaptureDevice.requestAccess(for: .video) { response in
            if response {
                print(response)
            } else {
            }
        }
    }

}

extension CustomBarViewController: UITabBarControllerDelegate {
    
}
