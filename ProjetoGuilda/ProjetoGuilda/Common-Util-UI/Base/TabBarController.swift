//
//  TabBarController.swift
//  ProjetoGuilda
//
//  Created by Pedro Menezes on 27/10/20.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.tintColor = .gray
        self.tabBar.backgroundColor = .white
        
        self.tabBar.isTranslucent = false
        self.tabBar.layer.shadowOffset = CGSize.zero
        self.tabBar.layer.shadowRadius = 2
        self.tabBar.layer.shadowColor = UIColor.gray.cgColor
        self.tabBar.layer.shadowOpacity = 1
        
        self.configureTabBar()
    }
    
    func configureTabBar() {
        
        
        let controllers = [
            HomeViewController(),
            SecondViewController()
//            Coordinator.homeViewController(),
//            Coordinator.exploreViewController(),
//            Coordinator.favoritesViewController(),
//            Coordinator.menuViewController()
        ]
        
        self.viewControllers = controllers.map {
            NavigationController(rootViewController: $0)
        }
        
        controllers.forEach({ (vc) in
            
            if vc.isKind(of: HomeViewController.self) {
                let imageSelected = UIImage(named: "home-fill")?.icon(size: 30)
                let image = UIImage(named: "home")?.icon(size: 30)
                let item = UITabBarItem(title: nil, image: image, selectedImage: imageSelected)
                vc.tabBarItem = item
                vc.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5,left: 0,bottom: -5,right: 0)
            }
            
            if vc.isKind(of: SecondViewController.self) {
                let imageSelected = UIImage(named: "home-fill")?.icon(size: 30)
                let image = UIImage(named: "home")?.icon(size: 30)
                let item = UITabBarItem(title: nil, image: image, selectedImage: imageSelected)
                vc.tabBarItem = item
                vc.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5,left: 0,bottom: -5,right: 0)
            }
        })
        
        
    }
}

