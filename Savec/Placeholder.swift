//
//  Placeholder.swift
//  Savec
//
//  Created by Xinpeng Hu on 20/03/18.
//  Copyright © 2018年 NUS. All rights reserved.
//

import UIKit

class Placeholder: TemplateViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIButton(frame: CGRect(x: 20, y: 60, width: 50, height: 30))
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(getBack), for: .touchDown)
        backButton.tintColor = UIColor.white
        view.addSubview(backButton)
    }
    
    @objc private func getBack() -> Void{
        let moreController = MainTabBarControl()
        moreController.selectedIndex = 3
     //   moreController.modalPresentationStyle = .custom
     //   moreController.modalTransitionStyle = .crossDissolve
        self.present(moreController, animated: false, completion: nil)
    }
}
