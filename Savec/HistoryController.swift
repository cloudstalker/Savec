//
//  HistoryController.swift
//  Savec
//
//  The viewController (plus a UICollectionViewCell subclass) for the History page
//
//  Created by Xinpeng Hu on 2018/3/11.
//  Copyright © 2018年 NUS. All rights reserved.
//

import UIKit

class HistoryController:TemplateViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    var monthPanel: UILabel!
    var infoPanel: UILabel!
    var now: Date!
    var today: Calendar!
    var daysOfMonth: DateInterval!
    var firstWeekDayOfMonth: Int!
    var lastDayOfMonth: Int!
    var datesCollection: UICollectionView!
    var weekCollection: UICollectionView!
    let weekdays = ["Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat"]
    var wrapper: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setTitle(title: "History")
        
        now = Date()
        initDateSettings()
        
        wrapper = UIStackView()
        view.addSubview(wrapper)
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.topAnchor.constraint(equalTo: view.subviews[0].bottomAnchor, constant: 50.0).isActive = true
        wrapper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wrapper.spacing = 0
        wrapper.distribution = .equalSpacing
        wrapper.axis = .vertical
        
        monthPanel = UILabel()
        monthPanel.widthAnchor.constraint(equalToConstant: CGFloat(Constants.scrWidth - 40)).isActive = true
        monthPanel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        monthPanel.font = UIFont(name: "Didot-Bold", size: 20)
        monthPanel.textColor = UIColor.white
        monthPanel.textAlignment = NSTextAlignment.center
        monthPanel.text = getMonthName(today.component(.month, from: now)) + " " + String(today.component(.year, from: now))
        monthPanel.layer.cornerRadius = CGFloat(Constants.roundRadius)
        monthPanel.layer.backgroundColor = UIColor.savecGreen.cgColor
        
        let weekLayout = UICollectionViewFlowLayout()
        weekLayout.sectionInset = UIEdgeInsets(top: 10, left:10, bottom: 10, right:10)
        weekLayout.itemSize = CGSize(width: Constants.weekUnitWidth, height: Constants.weekUnitHeight)
        
        weekCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: weekLayout)
        weekCollection.translatesAutoresizingMaskIntoConstraints = false
        weekCollection.widthAnchor.constraint(equalToConstant: CGFloat(Constants.scrWidth - 40)).isActive = true
        weekCollection.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        weekCollection.dataSource = self
        weekCollection.delegate = self
        weekCollection.register(WeekCell.self, forCellWithReuseIdentifier: "WeekCell")
        weekCollection.backgroundColor = UIColor.white
        weekCollection.allowsSelection = false
        weekCollection.layer.masksToBounds = false
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left:10, bottom: 10, right:10)
        layout.itemSize = CGSize(width: Constants.calendarUnitWidth, height: Constants.calendarUnitHeight)
        
        datesCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        datesCollection.translatesAutoresizingMaskIntoConstraints = false
        datesCollection.widthAnchor.constraint(equalToConstant: CGFloat(Constants.scrWidth - 40)).isActive = true
        datesCollection.heightAnchor.constraint(equalToConstant: CGFloat(Constants.scrHeight / 2)).isActive = true
        datesCollection.dataSource = self
        datesCollection.delegate = self
        datesCollection.register(CalendarCell.self, forCellWithReuseIdentifier: "DatesCell")
        datesCollection.backgroundColor = UIColor.white
        datesCollection.isScrollEnabled = false
//        datesCollection.layer.masksToBounds = false
//        datesCollection.layer.shadowRadius = 2
//        datesCollection.layer.shadowOffset = CGSize(width: 0, height: 2)
//        datesCollection.layer.shadowColor = UIColor.gray.cgColor
//        datesCollection.layer.shadowOpacity = 1.0
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        leftSwipe.direction = .left
        datesCollection.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        rightSwipe.direction = .right
        datesCollection.addGestureRecognizer(rightSwipe)
        
        infoPanel = UILabel()
        infoPanel.translatesAutoresizingMaskIntoConstraints = false
        infoPanel.widthAnchor.constraint(equalToConstant: CGFloat(Constants.scrWidth - 40)).isActive = true
        infoPanel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoPanel.font = UIFont(name: "Arial", size: 15)
        infoPanel.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        infoPanel.textColor = UIColor.black
        
        wrapper.addArrangedSubview(monthPanel)
        wrapper.addArrangedSubview(weekCollection)
        wrapper.addArrangedSubview(datesCollection)
        wrapper.addArrangedSubview(infoPanel)
        
//        let shadowCaster = UIView(frame: CGRect(x:20, y: 150, width: 200, height: 200))
//        shadowCaster.layer.masksToBounds = false
//        shadowCaster.layer.shadowColor = UIColor.gray.cgColor
//        shadowCaster.layer.shadowOffset = CGSize(width: 0, height: 2)
//        shadowCaster.layer.shadowRadius = 2
//        shadowCaster.layer.shadowOpacity = 1.0
//        shadowCaster.backgroundColor = UIColor.white
//        view.addSubview(shadowCaster)
//        view.bringSubview(toFront: shadowCaster)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let backgroundOfWrapper = UIView()
        backgroundOfWrapper.topAnchor.constraint(equalTo: monthPanel.bottomAnchor, constant: 5)
        backgroundOfWrapper.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor)
        backgroundOfWrapper.leftAnchor.constraint(equalTo: wrapper.leftAnchor)
        backgroundOfWrapper.rightAnchor.constraint(equalTo: wrapper.rightAnchor)
        backgroundOfWrapper.backgroundColor = UIColor.white
        backgroundOfWrapper.layer.cornerRadius = CGFloat(Constants.roundRadius)
        backgroundOfWrapper.layer.masksToBounds = false
//        backgroundOfWrapper.layer.shadowColor = UIColor.gray.cgColor
//        backgroundOfWrapper.layer.shadowOffset = CGSize(width: 0, height: 2)
//        backgroundOfWrapper.layer.shadowRadius = 1
//        backgroundOfWrapper.layer.shadowOpacity = 1.0
        view.addSubview(backgroundOfWrapper)
        view.sendSubview(toBack: backgroundOfWrapper)
        
        let leftMask = UIView()
        view.addSubview(leftMask)
        leftMask.translatesAutoresizingMaskIntoConstraints = false
        leftMask.topAnchor.constraint(equalTo: wrapper.topAnchor).isActive = true
        leftMask.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftMask.trailingAnchor.constraint(equalTo: wrapper.leadingAnchor).isActive = true
        leftMask.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor).isActive = true
        leftMask.backgroundColor = UIColor.savecSoil

        let rightMask = UIView()
        view.addSubview(rightMask)
        rightMask.translatesAutoresizingMaskIntoConstraints = false
        rightMask.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: -10).isActive = true
        rightMask.leadingAnchor.constraint(equalTo: wrapper.trailingAnchor).isActive = true
        rightMask.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightMask.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: 10).isActive = true
        rightMask.backgroundColor = UIColor.savecSoil

    }
    
    func initDateSettings(){
        today = Calendar.current
        today.locale = .current
        daysOfMonth = today.dateInterval(of: .month, for: now)
        lastDayOfMonth = today.component(.day, from: daysOfMonth.end - 1)
        firstWeekDayOfMonth = today.component(.weekday, from: daysOfMonth.start)
    }
    
    func animationSwipe(option: String){
        switch option {
        case "Left":
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.duration = 0.5
            transition.fillMode = kCAFillModeRemoved
            datesCollection.layer.add(transition, forKey: "transition")
        case "Right":
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            transition.duration = 0.5
            transition.fillMode = kCAFillModeRemoved
            datesCollection.layer.add(transition, forKey: "transition")
        default:
            break
        }
    }
    @objc func swipeLeft(){
        animationSwipe(option: "Left")
        now = Calendar.current.date(byAdding: .month, value: 1, to: now)
        monthPanel.text = getMonthName(today.component(.month, from: now)) + " " + String(today.component(.year, from: now))
        initDateSettings()
        datesCollection.reloadData()
    }
    
    @objc func swipeRight(){
        animationSwipe(option: "Right")
        now = Calendar.current.date(byAdding: .month, value: -1, to: now)
        monthPanel.text = getMonthName(today.component(.month, from: now)) + " " + String(today.component(.year, from: now))
        initDateSettings()
        datesCollection.reloadData()
    }
    
    func getMonthName(_ number:Int) -> String{
        switch number {
        case 1:
            return "January"
        case 2:
            return "Feburary"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "Wrong input!"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == datesCollection{
            return 42
        }
        else{
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == datesCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatesCell", for: indexPath) as! CalendarCell
            let currentDay = indexPath.item - (firstWeekDayOfMonth - 2)
            if (indexPath.item >= (firstWeekDayOfMonth - 1) && currentDay <= lastDayOfMonth){
                cell.date.text = String(currentDay)
                cell.notifier.backgroundColor = UIColor.savecGreen
            }
            else{
                cell.date.text = " "
                cell.notifier.backgroundColor = UIColor.white
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekCell", for: indexPath) as! WeekCell
            cell.label.text = weekdays[indexPath.item]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == datesCollection{
            infoPanel.text = "You have selected: " + String(indexPath.item - (firstWeekDayOfMonth - 2)) + " " + getMonthName(today.component(.month, from: now))
            let selectedCell = collectionView.cellForItem(at: indexPath)
            selectedCell?.backgroundColor = UIColor.white
        }
        else{
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == datesCollection{
            let selectedCell = collectionView.cellForItem(at: indexPath)
            selectedCell?.backgroundColor = UIColor.white
        }
        else{
        }
    }
}

class CalendarCell: UICollectionViewCell{
    var date: UILabel!
    var notifier: UIView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        date = UILabel(frame: CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height - 10))
        date.font = UIFont(name: "Arial", size: 15)
        date.textColor = UIColor.black
        date.textAlignment = NSTextAlignment.center
        
        notifier = UIView(frame: CGRect(x: self.bounds.midX - 2.5, y: self.bounds.height - 10, width: 5, height: 5))
        notifier.layer.cornerRadius = 2.5
        
        contentView.addSubview(notifier)
        contentView.addSubview(date)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WeekCell: UICollectionViewCell{
    var label: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        label = UILabel(frame: self.bounds)
        label.font = UIFont(name: "Arial", size: 12)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
