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
        let topBg = UIView.init(frame: CGRect(x: 0, y: 0, width: Constants.scrWidth, height: Constants.maskHeight))
        topBg.backgroundColor = UIColor.savecGreen
        view.backgroundColor = UIColor.savecSoil
        view.addSubview(topBg)
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func setTitle(title: String) -> Void{
        let titleShown = UILabel(frame: CGRect(x: 0, y: 50, width: Constants.scrWidth, height: 30))
        titleShown.text = title
        titleShown.font = UIFont.init(name: "Arial", size: 20)
        titleShown.textColor = UIColor.white
        titleShown.textAlignment = NSTextAlignment.center
        view.addSubview(titleShown)
    }
}
