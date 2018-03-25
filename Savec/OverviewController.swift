//
//  OverviewController.swift
//  Savec
//
//  The viewController for the Overview page
//
//  Created by Xinpeng Hu on 2018/3/11.
//  Copyright © 2018年 NUS. All rights reserved.
//

import UIKit

public class OverviewController:TemplateViewController{
    
    var infoContainer = UIStackView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        super.setTitle(title: "Overview")
        infoContainer.axis = .vertical
        infoContainer.distribution = UIStackViewDistribution.equalSpacing
        infoContainer.alignment = .center
        infoContainer.spacing = Constants.stackSpacing
        
        let containedTop = InfoUnit(Constants.stackSpacing + Constants.infoWidth * 2, Constants.infoTopHeight, Constants.infoBotHeight, which: "top")
        infoContainer.addArrangedSubview(containedTop)
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let containedBtm = UIStackView()
        containedBtm.axis = .horizontal
        let btmLeft = InfoUnit(Constants.infoWidth, Constants.infoTopHeight, Constants.infoBotHeight, which: "btmLeft")
        let btmRight = InfoUnit(Constants.infoWidth, Constants.infoTopHeight, Constants.infoBotHeight, which: "btmRight")
        containedBtm.distribution = UIStackViewDistribution.equalSpacing
        containedBtm.spacing = Constants.stackSpacing
        containedBtm.addArrangedSubview(btmLeft)
        containedBtm.addArrangedSubview(btmRight)
        containedBtm.translatesAutoresizingMaskIntoConstraints = false
        infoContainer.addArrangedSubview(containedBtm)
        
        view.addSubview(infoContainer)
        infoContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    public override func viewDidLayoutSubviews() {
        let avatar = UIImageView(frame: CGRect(x: 0,y: 0,width: Constants.avatarRadius * 2,height: Constants.avatarRadius * 2))
        avatar.center = CGPoint(x:infoContainer.frame.maxX - Constants.avatarRadius, y: infoContainer.frame.minY)
        avatar.backgroundColor = UIColor.white
        avatar.layer.cornerRadius = Constants.avatarRadius
        avatar.layer.shadowRadius = 2
        avatar.layer.shadowOffset = CGSize(width: 1, height: 1)
        avatar.layer.shadowColor = UIColor.gray.cgColor
        avatar.layer.shadowOpacity = 1
        avatar.image = #imageLiteral(resourceName: "Avatar")
        view.addSubview(avatar)
    }

    public func InfoUnit(_ width: CGFloat, _ heightOfT: CGFloat, _ heightOfB: CGFloat, which: String) -> UIStackView{
        let subContainer = UIStackView()
        subContainer.axis = .vertical
        subContainer.distribution = UIStackViewDistribution.equalSpacing
        subContainer.spacing = 0
        
        let topRect = UIView()
        topRect.backgroundColor = UIColor.white
        topRect.heightAnchor.constraint(equalToConstant: heightOfT).isActive = true
        topRect.widthAnchor.constraint(equalToConstant: width).isActive = true
        let topLabel = UILabel(frame: topRect.bounds)
        switch which {
        case "top":
            topLabel.text = "Stickers"
        case "btmLeft":
            topLabel.text = "Rewards available"
        case "btmRight":
            topLabel.text = "Current Ranking"
        default:
            topLabel.text = "Error: option non-exist"
        }
        topLabel.font = UIFont.init(name: "Arial", size: 15)
        topLabel.textColor = UIColor.black
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topRect.addSubview(topLabel)
        
        let btmRect = UIView()
        btmRect.backgroundColor = UIColor.lightGray
        btmRect.alpha = 0.5
        btmRect.heightAnchor.constraint(equalToConstant: heightOfB).isActive = true
        btmRect.widthAnchor.constraint(equalToConstant: width).isActive = true
        let btmLabel = UILabel(frame: btmRect.bounds)
        switch which {
        // Data to put here for no. of stickers
        case "top":
            btmLabel.text = "7 X"
        // Data to put here for no. of available rewards
        case "btmLeft":
            btmLabel.text = "1"
        // Data to put here for current ranking
        case "btmRight":
            btmLabel.text = "No. 15"
        default:
            btmLabel.text = "Error: option non-existent"
        }
        btmLabel.font = UIFont.init(name: "Arial", size: 30)
        btmLabel.textColor = UIColor.black
        btmLabel.textAlignment = NSTextAlignment.center
        btmLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        btmRect.addSubview(btmLabel)
        
        subContainer.addArrangedSubview(topRect)
        subContainer.addArrangedSubview(btmRect)
        
        let msgBoxBg = UIView(frame: subContainer.bounds)
        msgBoxBg.backgroundColor = UIColor.white
        msgBoxBg.layer.shadowColor = UIColor.gray.cgColor
        msgBoxBg.layer.shadowOffset = CGSize(width: 0, height: 1)
        msgBoxBg.layer.shadowOpacity = 0.8
        msgBoxBg.layer.shadowRadius = 2
        msgBoxBg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subContainer.insertSubview(msgBoxBg, at: 0)
        return subContainer
        }
}
