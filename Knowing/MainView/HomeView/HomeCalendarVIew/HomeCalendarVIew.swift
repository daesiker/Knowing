//
//  HomeCalendarVIew.swift
//  Knowing
//
//  Created by Jun on 2021/10/27.
//

import Foundation
import UIKit
import FSCalendar
import RxCocoa
import RxSwift
import SwipeCellKit
import RxDataSources

class HomeCalendarView: UIView {
    
    let disposeBag = DisposeBag()
    let cellID = "cellID"
    let headerID = "headerID"
    
    
    let calendarCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let imgView = UIImageView(image: UIImage(named: "calenderView")!).then {
        $0.isUserInteractionEnabled = true
    }
    
    lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cellId")
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.weekdayFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        calendar.appearance.weekdayTextColor = UIColor.rgb(red: 188, green: 131, blue: 92)
        calendar.placeholderType = .fillHeadTail
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.headerHeight = 0
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = UIColor.rgb(red: 255, green: 92, blue: 20)
        calendar.appearance.todaySelectionColor = .clear
        calendar.appearance.selectionColor = UIColor.rgb(red: 255, green: 142, blue: 85)
        calendar.appearance.titleSelectionColor = .white
        calendar.appearance.eventDefaultColor = UIColor.rgb(red: 255, green: 161, blue: 102)
        calendar.appearance.eventSelectionColor = UIColor.rgb(red: 255, green: 161, blue: 102)
        return calendar
    }()
    
    let leftBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "calendarLf"), for: .normal)
        $0.isEnabled = true
    }
    
    let titleLb = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeoEB", size: 21)
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
    }
    
    let rightBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "calendarRg"), for: .normal)
        $0.isEnabled = true
    }
    
    
    let chartData = Observable<[String]>.of(["", "", "", "", "", ""])
    let headerData = Observable<String>.of("")
    
    let testData = ["", "", "", "", "", ""]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCV()
        setUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCalendarView {
    
    func setCV() {
        calendarCV.delegate = self
        calendarCV.dataSource = self
        
        calendarCV.register(CalendarCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func setUI() {
        backgroundColor = .white
        addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        setTitle()
        
        imgView.addSubview(leftBt)
        leftBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(129)
            $0.leading.equalToSuperview().offset(26)
        }
        
        imgView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(129)
            $0.leading.equalTo(leftBt.snp.trailing).offset(1)
        }
        
        imgView.addSubview(rightBt)
        rightBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(129)
            $0.leading.equalTo(titleLb.snp.trailing).offset(1)
        }
        
        
        imgView.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.height.equalTo(294)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(titleLb.snp.bottom).offset(20)
        }
        
        addSubview(calendarCV)
        calendarCV.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-91)
        }
    }
    
    func bind() {
        leftBt.rx.tap.subscribe(onNext: {
            let _calendar = Calendar.current
            var dateComponents = DateComponents()
            
            dateComponents.month = -1 // For prev button
            self.calendarView.currentPage = _calendar.date(byAdding: dateComponents, to: self.calendarView.currentPage)!
            
            self.calendarView.setCurrentPage(self.calendarView.currentPage, animated: true)
            self.setTitle()
        }).disposed(by: disposeBag)
        
        rightBt.rx.tap.subscribe(onNext: {
            let _calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.month = 1
            self.calendarView.currentPage = _calendar.date(byAdding: dateComponents, to: self.calendarView.currentPage)!
            
            self.calendarView.setCurrentPage(self.calendarView.currentPage, animated: true)
            self.setTitle()
            
        }).disposed(by: disposeBag)
        
    }
    
    func setTitle() {
        let date = calendarView.currentPage
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        let title = dateFormatter.string(from: date)
        titleLb.text = title
    }
    
    
}

extension HomeCalendarView: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 3
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cellId", for: date, at: position)
        return cell
    }
    
}

extension HomeCalendarView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CalendarCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width - 40
        return CGSize(width: width, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
}





class CalendarCell: SwipeCollectionViewCell {
    
    let imgView = UIImageView(image: UIImage(named: "seoul")!)
    
    let titleLb = UILabel().then {
        $0.text = "청년월세지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.textColor = UIColor.rgb(red: 38, green: 38, blue: 38)
    }
    
    let subLb = UILabel().then {
        $0.text = "서울시"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 122, green: 122, blue: 122)
    }
    
    let alertImg = UIImageView(image: UIImage(named: "calendarAlert"))
    let unalertImg = UIImageView(image: UIImage(named: "calendarUnalert"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        
        contentView.backgroundColor = UIColor.rgb(red: 255, green: 246, blue: 232)
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(14)
            $0.top.equalToSuperview().offset(15)
        }
        
        contentView.addSubview(subLb)
        subLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(9)
            $0.leading.equalTo(imgView.snp.trailing).offset(14)
        }
        
        contentView.addSubview(alertImg)
        alertImg.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-11)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    func configure(name: String?) {
        
    }
}
