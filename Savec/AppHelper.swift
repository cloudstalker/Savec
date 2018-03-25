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
    // height of the top green background
    static let maskHeight = 100
    
    static let infoTopHeight:CGFloat = 30
    static let infoBotHeight:CGFloat = 100
    static let infoWidth:CGFloat = CGFloat(Constants.scrWidth - 60) / 2
    
    static let avatarRadius:CGFloat = 25
    
    static let stackSpacing:CGFloat = 20.0
    
    static let calendarUnitWidth:CGFloat = CGFloat(Constants.scrWidth - 120) / 7
    static let calendarUnitHeight:CGFloat = CGFloat(Constants.scrHeight / 2 - 60) / 6
    static let weekUnitWidth:CGFloat = Constants.calendarUnitWidth
    static let weekUnitHeight:CGFloat = 20.0
    
}

// Custom color for this app

extension UIColor{
    static let savecGreen = UIColor(red: 99.0/255, green: 165.0/255, blue: 91.0/255, alpha: 1.0)
    static let savecSoil = UIColor(red: 235.0/255, green: 215.0/255, blue: 186.0/255, alpha: 1.0)
    static let savecSoilDark = UIColor(red: 232.0/255, green: 204.0/255, blue: 162.0/255, alpha: 1.0)
}
