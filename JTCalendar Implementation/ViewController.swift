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
        view.scrollDirection = .horizontal
        view.scrollingMode = .stopAtEachSection
        view.minimumInteritemSpacing = 0
        view.minimumLineSpacing = 0
        view.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
        return view
    }()
    
    let prefButton = UIButton()
    let nextButton = UIButton()
    let monthLabel = UILabel()
    lazy var calendarNavigation: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        
        prefButton.translatesAutoresizingMaskIntoConstraints = false
        prefButton.setTitle("Pref", for: .normal)
        prefButton.backgroundColor = .black
        prefButton.addTarget(self, action: #selector(didTapNavigation(sender:)), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .black
        nextButton.addTarget(self, action: #selector(didTapNavigation(sender:)), for: .touchUpInside)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.textAlignment = .center
        monthLabel.backgroundColor = .black
        monthLabel.textColor = .white
        
        view.addArrangedSubview(prefButton)
        view.addArrangedSubview(monthLabel)
        view.addArrangedSubview(nextButton)
        
        return view
    }()
    
    let formatter = DateFormatter()
    let currentCalendar = Calendar.current
    var dateNow = Date()
    var endDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        formatter.dateFormat = "yyyy MM dd"
        setupCalendarView()
        calendarView.scrollToSegment(.end)
    }
    
    func setupCalendarView(){
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leftAnchor.constraint(equalTo: view.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.rightAnchor),
            calendarView.heightAnchor.constraint(equalTo: calendarView.widthAnchor)
            ])
        
        view.addSubview(calendarNavigation)
        NSLayoutConstraint.activate([
            calendarNavigation.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            calendarNavigation.leftAnchor.constraint(equalTo: view.leftAnchor),
            calendarNavigation.rightAnchor.constraint(equalTo: view.rightAnchor),
            calendarNavigation.heightAnchor.constraint(equalToConstant: 48)
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateNow = Date()
        endDate = dateNow
    }

    @objc func didTapNavigation(sender: UIButton){
        if sender == prefButton{
            calendarView.scrollToSegment(.previous)
        }else{
            calendarView.scrollToSegment(.next)
        }
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
        endDate = dateNow                                   // You can also use dates created from this function
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
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let currentMonth = visibleDates.monthDates.first
        monthLabel.text = "\(currentMonth?.date.string(format: "MMMM yyyy") ?? "")"
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

