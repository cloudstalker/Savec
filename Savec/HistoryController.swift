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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setTitle(title: "History")
        
        now = Date()
        initDateSettings()
        
        monthPanel = UILabel(frame: CGRect(x: 10, y: 160, width: Constants.scrWidth - 20, height: 50))
        monthPanel.font = UIFont(name: "Arial", size: 20)
        monthPanel.backgroundColor = UIColor.savecGreen
        monthPanel.textColor = UIColor.black
        monthPanel.textAlignment = NSTextAlignment.center
        monthPanel.text = getMonthName(today.component(.month, from: now)) + " " + String(today.component(.year, from: now))
        view.addSubview(monthPanel)
        
        let weekLayout = UICollectionViewFlowLayout()
        weekLayout.sectionInset = UIEdgeInsets(top: 10, left:10, bottom: 10, right:10)
        weekLayout.itemSize = CGSize(width: Constants.weekUnitWidth, height: Constants.weekUnitHeight)
        
        weekCollection = UICollectionView(frame: CGRect(x: 10, y: 210, width: Constants.scrWidth - 20, height: 50), collectionViewLayout: weekLayout)
        weekCollection.dataSource = self
        weekCollection.delegate = self
        weekCollection.register(WeekCell.self, forCellWithReuseIdentifier: "WeekCell")
        weekCollection.backgroundColor = UIColor.savecGreen
        weekCollection.allowsSelection = false
        view.addSubview(weekCollection)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left:10, bottom: 10, right:10)
        layout.itemSize = CGSize(width: Constants.calendarUnitWidth, height: Constants.calendarUnitHeight)
        
        datesCollection = UICollectionView(frame: CGRect(x: 10, y: 260, width: Constants.scrWidth - 20, height: Constants.scrHeight - Constants.tabBarHeight - 370), collectionViewLayout: layout)
        datesCollection.dataSource = self
        datesCollection.delegate = self
        datesCollection.register(CalendarCell.self, forCellWithReuseIdentifier: "DatesCell")
        datesCollection.backgroundColor = UIColor.white
        datesCollection.layer.shadowOffset = CGSize(width:0 ,height: 2)
        datesCollection.layer.shadowColor = UIColor.gray.cgColor
        datesCollection.layer.shadowRadius = 2
        datesCollection.layer.shadowOpacity = 1
        datesCollection.layer.masksToBounds = false
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        leftSwipe.direction = .left
        datesCollection.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        rightSwipe.direction = .right
        datesCollection.addGestureRecognizer(rightSwipe)
        view.addSubview(datesCollection)
        
        infoPanel = UILabel(frame: CGRect(x: 10, y: Constants.scrHeight - Constants.tabBarHeight - 110, width: Constants.scrWidth - 20, height: 50))
        infoPanel.font = UIFont(name: "Arial", size: 15)
        infoPanel.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        infoPanel.textColor = UIColor.black
        view.addSubview(infoPanel)
    }
    
    func initDateSettings(){
        today = Calendar.current
        today.locale = .current
        daysOfMonth = today.dateInterval(of: .month, for: now)
        lastDayOfMonth = today.component(.day, from: daysOfMonth.end - 1)
        firstWeekDayOfMonth = today.component(.weekday, from: daysOfMonth.start)
    }
    
    @objc func swipeLeft(){
        now = Calendar.current.date(byAdding: .month, value: 1, to: now)
        monthPanel.text = getMonthName(today.component(.month, from: now)) + " " + String(today.component(.year, from: now))
        initDateSettings()
        datesCollection.reloadData()
    }
    
    @objc func swipeRight(){
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
                cell.notifier.backgroundColor = UIColor.gray
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
            selectedCell?.backgroundColor = UIColor.savecGreen
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
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
