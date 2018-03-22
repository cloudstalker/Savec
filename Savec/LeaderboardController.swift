//
//  LeaderboardController.swift
//  Savec
//
//  This is a page for showing the user's ranking
//
//  Created by Xinpeng Hu on 2018/3/11.
//  Copyright © 2018年 NUS. All rights reserved.
//

import UIKit

class LeaderboardController:TemplateViewController, UITableViewDelegate, UITableViewDataSource{
    
    let userRank = ["Azize", "Boris", "Cemil", "Doruk"]
    let facRank = ["Alexandria", "Bagdad", "Constatinople", "Dunhuang"]
    var rankList: UITableView! = nil
    var currentSegment = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setTitle(title: "Leaderboard")

        let segRank = UISegmentedControl(frame: CGRect(x: 30, y: 120, width: Constants.scrWidth - 60, height: 30))
        segRank.insertSegment(withTitle: "Users", at: 0, animated: false)
        segRank.insertSegment(withTitle: "Faculties", at: 1, animated: false)
        segRank.tintColor = UIColor.savecGreen
        segRank.backgroundColor = UIColor.white
        segRank.layer.borderWidth = 2
        segRank.layer.cornerRadius = 2
        segRank.layer.borderColor = UIColor.white.cgColor
        segRank.addTarget(self, action: #selector(segValueChanged), for: .valueChanged)
        segRank.selectedSegmentIndex = currentSegment
        view.addSubview(segRank)
        
        rankList = UITableView(frame: CGRect(x: 30, y: 150, width: Constants.scrWidth - 60, height: 300))
        rankList.delegate = self
        rankList.dataSource = self
        rankList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        rankList.allowsSelection = false
        
        
        let rankListContainer = UIView(frame: rankList.frame)
        rankListContainer.backgroundColor = UIColor.white
        rankListContainer.layer.shadowOffset = CGSize(width: 0, height: 3)
        rankListContainer.layer.shadowRadius = 2
        rankListContainer.layer.shadowOpacity = 1
        rankListContainer.layer.shadowColor = UIColor.gray.cgColor
        rankListContainer.layer.masksToBounds = false
        view.addSubview(rankListContainer)
        view.addSubview(rankList)
    }
    
    @objc func segValueChanged() -> Void {
        switch currentSegment {
        case 0:
            currentSegment = 1
            rankList.reloadData()
        case 1:
            currentSegment = 0
            rankList.reloadData()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentSegment {
        case 0:
            return userRank.count
        case 1:
            return facRank.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        switch currentSegment {
        case 0:
            cell.textLabel?.text = userRank[indexPath.item]
        case 1:
            cell.textLabel?.text = facRank[indexPath.item]
        default:
            break
        }
        return cell
    }
}
