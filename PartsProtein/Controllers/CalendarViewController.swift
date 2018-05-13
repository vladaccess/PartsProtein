//
//  CalendarViewController.swift
//  PartsProtein
//
//  Created by attom on 13.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import pop
import UICountingLabel
import AHKActionSheet
import CVCalendar

class CalendarViewController: UIViewController {
    
    var userDefaults = UserDefaults.groupUserDefaults()
    @IBOutlet weak var calendarMenu:CVCalendarMenuView!
    @IBOutlet weak var calendarContent:CVCalendarView!
    @IBOutlet weak var dailyLabel:UILabel!
    @IBOutlet weak var addButton:UIButton!
    @IBOutlet weak var monthLabel:UILabel!
    @IBOutlet weak var quantityLabel:UICountingLabel!
    @IBOutlet weak var measureLabel:UILabel!
    @IBOutlet weak var daysCountLabel:UICountingLabel!
    @IBOutlet weak var daysLabel:UILabel!
    @IBOutlet weak var shareButton:UIButton!
    @IBOutlet weak var daysLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var shareButtonConstaints: NSLayoutConstraint!
    @IBOutlet weak var quantityLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarConstraints: NSLayoutConstraint!
    
    
    var quantityLabelStartingConstant = 0.0
    var daysLabelStartingConstant = 0.0
    var shareButtonStartingConstant = 0.0
    var showingStats = false
    var animating = false
    
    override func viewDidLoad() {
        title = "My Progress"
        super.viewDidLoad()
        dailyLabel.text = ""
        [quantityLabel,daysCountLabel].forEach { $0.format = "%d" }
        [quantityLabel,daysCountLabel,daysLabel,measureLabel].forEach { $0?.textColor = Tint.mainTint}
        shareButton.backgroundColor = Tint.mainTint
        
        setupCalendar()
        initAnimations()
    }
    
    lazy var actionSheet:AHKActionSheet = {
        let actionSheet = AHKActionSheet(title: "Add a new portion:")
        actionSheet?.addButton(withTitle: "Small part", type: AHKActionSheetButtonType.default, handler: { (action) in
            self.addPart(ofSize:.small)
        })
        actionSheet?.addButton(withTitle: "Big part", type: AHKActionSheetButtonType.default, handler: { (action) in
            self.addPart(ofSize:.big)
        })
        return actionSheet!
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCalendarView()
    }
    
    func addPart(ofSize:Constants.Part) {
        if let selectedDate = calendarContent.coordinator.selectedDayView?.date.convertedDate() {
            EntryHandler.shared.addPart(userDefaults.double(forKey: ofSize.key()), date: selectedDate)
            updateCalendarView()
            
            dailyLabel.text = dateLabelString(selectedDate)
        }else {
            dailyLabel.text = dateLabelString()
        }
    }
    
    @IBAction func shareAction(_ sender:UIButton) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Global.showPopTipOnceForKey("SHARE", userDefaults: userDefaults,
                                     popTipText: NSLocalizedString("share poptip", comment: ""),
                                     inView: view,
                                     fromFrame: CGRect(x: view.frame.size.width - 28, y: -10, width: 1, height: 1))
        
        dailyLabel.text = dateLabelString(Date())
    }
    
    
    func updateCalendarView() {
        calendarMenu.commitMenuViewUpdate()
        calendarContent.commitCalendarViewUpdate()
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        monthLabel.text = date.globalDescription
    }
    
    @IBAction func addExtraPart(_ sender:UIButton) {
        actionSheet.show()
    }

}

extension CalendarViewController {
    func setupCalendar() {
        calendarMenu.menuViewDelegate = self
        calendarContent.calendarDelegate = self
        calendarContent.calendarAppearanceDelegate = self
        
        monthLabel.text = CVDate(date: Date()).globalDescription
        if let font = UIFont(name: "KaushanScript-Regular", size: 16) {
            monthLabel.font = font
            monthLabel.textAlignment = .center
            monthLabel.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        }
    }
}

extension CalendarViewController:CVCalendarViewDelegate,CVCalendarMenuViewDelegate,CVCalendarViewAppearanceDelegate {
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }
    
    func latestSelectableDate() -> Date {
        return Date()
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        guard let percentege = percentage(for:dayView.date.convertedDate()) else { return false }
        return percentege > 0.0
    }
    
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        guard let date = dayView.date.convertedDate(),let persentage = percentage(for: date) else { return [] }
        return persentage >= 1.0 ? [Tint.mainTint] : [Tint.tint_destructive]
    }
    
    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
         return Tint.mainTint
    }
    
    fileprivate func percentage(for date:Date?) -> Double? {
        guard let date = date,let entry = EntryHandler.shared.entryForDate(date: date) else { return nil }
        return Double(entry.percentage / 100.0)
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        guard let date = dayView.date.convertedDate() else { return }
        dailyLabel.text = dateLabelString(date)
    }
    
    
    func dateLabelString(_ date:Date = Date()) -> String {
        if let entry = EntryHandler.shared.entryForDate(date: date) {
            if entry.percentage >= 100 {
                return "Goal done"
            }else {
                return entry.formattedPercentage()
            }
        }else {
            return ""
        }
    }
    
}
