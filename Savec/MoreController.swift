//
//  MoreController.swift
//  Savec
//
//  Created by Xinpeng Hu on 2018/3/11.
//  Copyright © 2018年 NUS. All rights reserved.
//

import UIKit

class MoreController:TemplateViewController, UITableViewDelegate, UITableViewDataSource{
 

    let options = [["Account", "Settings", "About"], ["Refer a friend", "Participating Vendors", "Rate this app on AppStore"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let optionsTable = UITableView(frame: CGRect(x: 20, y: 120, width: UIScreen.main.bounds.width - 2 * 20, height: self.view.frame.height), style: .grouped)
        optionsTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        optionsTable.delegate = self
        optionsTable.dataSource = self
        optionsTable.separatorStyle = .singleLine
        optionsTable.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        optionsTable.allowsSelection = true
        optionsTable.allowsMultipleSelection = false
        optionsTable.isScrollEnabled = false
        view.addSubview(optionsTable)
        super.setTitle(title: "More")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let temp = Placeholder()
  //      temp.modalPresentationStyle = .custom
  //      temp.modalTransitionStyle = .coverVertical
        self.present(temp, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        if let myLabel = cell.textLabel{
            myLabel.text = "\(options[indexPath.section][indexPath.row])"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
}
