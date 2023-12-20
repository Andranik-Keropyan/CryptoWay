//
//  GeneralTabBar.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import UIKit
import SnapKit

class GeneralTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        tabBar.barTintColor = UIColor.hexStringToUIColor(hex: "#161730")
        tabBar.unselectedItemTintColor = UIColor.white
        tabBar.tintColor = UIColor.green

        // Do any additional setup after loading the view.
    }
    
    func setupControllers() {
        var controllers: [UIViewController] = []
        
      
        let FirstVC = CryptoList()
        controllers.append(UINavigationController(rootViewController: FirstVC))
        FirstVC.tabBarItem = .init(title: "CryptoList", image: .init(systemName: "list.bullet"), tag: 0)
        
        let secondVC = ListOfExchanges()
        controllers.append(UINavigationController(rootViewController: secondVC))
        secondVC.tabBarItem = .init(title: "Exchages", image: .init(systemName: "arrow.triangle.2.circlepath"), tag: 1)
        
        let thirdVC = CryptoNews()
        controllers.append(UINavigationController(rootViewController: thirdVC))
        thirdVC.tabBarItem = .init(title: "News", image: .init(systemName: "newspaper"), tag: 2)

        let lastVC = MapController()
        controllers.append(UINavigationController(rootViewController: lastVC))
        lastVC.tabBarItem = .init(title: "Map", image: .init(systemName: "map"), tag: 3)

        self.viewControllers = controllers
    }
}
