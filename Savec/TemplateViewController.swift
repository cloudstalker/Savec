//
//  TemplateViewController.swift
//  Savec
//
//  Created by Xinpeng Hu on 2018/3/11.
//  Copyright © 2018年 NUS. All rights reserved.
//

import UIKit

public class TemplateViewController:UIViewController{

    public override func viewDidLoad() {
        super.viewDidLoad()
        let topBg = UIView(frame: CGRect(x: 0, y: 0, width: Constants.scrWidth, height: Constants.maskHeight))
        topBg.backgroundColor = UIColor.savecGreen
        topBg.layer.shadowOpacity = 1.0
        topBg.layer.shadowRadius = 2
        topBg.layer.shadowColor = UIColor.gray.cgColor
        topBg.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.backgroundColor = UIColor.savecSoil
        view.addSubview(topBg)
        
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func setTitle(title: String) -> Void{
        let titleShown = UILabel()
        view.addSubview(titleShown)
        titleShown.translatesAutoresizingMaskIntoConstraints = false
        titleShown.widthAnchor.constraint(equalToConstant: CGFloat(Constants.scrWidth)).isActive = true
        titleShown.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        titleShown.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleShown.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        titleShown.text = title
        titleShown.font = UIFont(name: "Arial", size: 20)
        titleShown.textColor = UIColor.white
        titleShown.textAlignment = NSTextAlignment.center
    }
}
