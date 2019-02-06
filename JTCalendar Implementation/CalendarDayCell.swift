//
//  CalendarCell.swift
//  JTCalendar Implementation
//
//  Created by riyo maulana on 05/02/19.
//  Copyright © 2019 Abhimantra. All rights reserved.
//

import JTAppleCalendar

class CalendarDayCell: JTAppleCell {
    //Setup label day properties here
    var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont(name: label.font.fontName, size: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dayLabel)
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
    }
    
}
