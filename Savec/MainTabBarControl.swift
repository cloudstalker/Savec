//
//  MainTabViewControl.swift
//  Savec
//
//  Created by Xinpeng Hu on 2018/3/11.
//  Copyright © 2018年 NUS. All rights reserved.
//

import UIKit

public class MainTabBarControl:UITabBarController{
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        let overview = OverviewController()
        let history = HistoryController()
        let leaderboard = LeaderboardController()
        let more = MoreController()
        overview.tabBarItem = UITabBarItem(title: "Overview", image: #imageLiteral(resourceName: "Home"), tag: 1)
        history.tabBarItem = UITabBarItem(title: "History", image: #imageLiteral(resourceName: "History"), tag: 2)
        leaderboard.tabBarItem = UITabBarItem(title: "Leaderboard", image: #imageLiteral(resourceName: "Earth"), tag: 3)
        more.tabBarItem = UITabBarItem(title:"More", image: #imageLiteral(resourceName: "More") , tag: 4)
        let controllers = [overview, history, leaderboard, more]
        viewControllers = controllers
        
        tabBar.tintColor = UIColor.savecGreen
        tabBar.barTintColor = UIColor.white
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowOpacity = 1.0
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
    }
}
