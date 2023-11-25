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
        // Do any additional setup after loading the view.
    }
    
    func setupControllers() {
        var controllers: [UIViewController] = []
      
        let FirstVC = CryptoList()
        controllers.append(UINavigationController(rootViewController: FirstVC))
        FirstVC.tabBarItem = .init(title: "CryptoList", image: .init(systemName: "person"), tag: 0)
        
        let secondVC = ListOfExchanges()
        controllers.append(UINavigationController(rootViewController: secondVC))
        secondVC.tabBarItem = .init(title: "Exchages", image: .init(systemName: "person"), tag: 1)
        
        let thirdVC = CryptoNews()
        controllers.append(UINavigationController(rootViewController: thirdVC))
        thirdVC.tabBarItem = .init(title: "News", image: .init(systemName: "person"), tag: 2)
        
        let lastVC = MapController()
        controllers.append(UINavigationController(rootViewController: lastVC))
        lastVC.tabBarItem = .init(title: "Map", image: .init(systemName: "person"), tag: 3)
        
        self.viewControllers = controllers
    }
    
    

   

}
