//
//  ViewController.swift
//  JTCalendar Implementation
//
//  Created by riyo maulana on 05/02/19.
//  Copyright © 2019 Abhimantra. All rights reserved.
//

import UIKit
import Foundation
import JTAppleCalendar

class ViewController: UIViewController {

    lazy var calendarView: JTAppleCalendarView = {
        let view = JTAppleCalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.calendarDataSource = self
        view.calendarDelegate = self
        view.backgroundColor = .black
        view.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
        return view
    }()
    let formatter = DateFormatter()
    let currentCalendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        formatter.dateFormat = "yyyy MM dd"
        setupCalendarView()
    }
    
    func setupCalendarView(){
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leftAnchor.constraint(equalTo: view.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.rightAnchor),
            calendarView.heightAnchor.constraint(equalTo: calendarView.widthAnchor)
            ])
    }

}

extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCustomCell = cell as! CalendarDayCell
        
        myCustomCell.dayLabel.text = "\(date.string(format: "dd"))"
        
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.dayLabel.textColor = .gray
        } else {
            myCustomCell.dayLabel.textColor = .blue
        }
        
        if cellState.isSelected{
            myCustomCell.backgroundColor = .red
        }else{
            myCustomCell.backgroundColor = .white
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as! CalendarDayCell
        self.calendar(calendar, willDisplay: myCustomCell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return myCustomCell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let startDate = formatter.date(from: "2016 01 01")! // You can use date generated from a formatter
        let endDate = Date()                                // You can also use dates created from this function
        let parameters = ConfigurationParameters(
            startDate: startDate,
            endDate: endDate,
            numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .sunday)
        
        return parameters
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

