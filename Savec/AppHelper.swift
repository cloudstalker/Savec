//
//  AppHelper.swift
//  Savec
//
//  Created by Xinpeng Hu on 2018/3/11.
//  Copyright © 2018年 NUS. All rights reserved.
//

import UIKit

struct Constants{
    
    static let scrWidth = Int(UIScreen.main.bounds.width)
    static let scrHeight = Int(UIScreen.main.bounds.height)
    static let maskHeight = 100
    static let tabBarHeight = 49
    
    static let infoTopHeight:CGFloat = 30
    static let infoBotHeight:CGFloat = 100
    static let infoWidth:CGFloat = 150
    
    static let stackSpacing:CGFloat = 20.0
    
    static let calendarUnitWidth:CGFloat = 40.0
    static let calendarUnitHeight:CGFloat = 40.0
    static let weekUnitWidth:CGFloat = 40.0
    static let weekUnitHeight:CGFloat = 20.0
    
}

extension UIColor{
    static let savecGreen = UIColor.init(red: 99.0/255, green: 165.0/255, blue: 91.0/255, alpha: 1.0)
    static let savecSoil = UIColor.init(red: 235.0/255, green: 215.0/255, blue: 186.0/255, alpha: 1.0)
}
