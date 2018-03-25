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
        let optionsTable = UITableView(frame: CGRect.null, style: .grouped)
        optionsTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        optionsTable.delegate = self
        optionsTable.dataSource = self
        optionsTable.separatorStyle = .singleLine
        optionsTable.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        optionsTable.allowsSelection = true
        optionsTable.allowsMultipleSelection = false
        optionsTable.isScrollEnabled = false
        optionsTable.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        view.addSubview(optionsTable)
        optionsTable.translatesAutoresizingMaskIntoConstraints = false
        optionsTable.topAnchor.constraint(equalTo: view.subviews[0].bottomAnchor, constant: 20).isActive = true
        optionsTable.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        optionsTable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        optionsTable.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
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
