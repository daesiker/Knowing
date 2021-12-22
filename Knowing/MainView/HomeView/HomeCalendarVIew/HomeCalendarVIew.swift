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
import Alamofire
import SwiftyJSON
import Firebase

class HomeCalendarView: UIView {
    
    let disposeBag = DisposeBag()
    let cellID = "cellID"
    let headerID = "headerID"
    let vm = MainTabViewModel.instance
    
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
        calendar.scrollEnabled = false
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
    
    let refreshControl = UIRefreshControl()
    
    var bookmarkData:[Post] = []
    var calendarData:[ClosedRange<Date>: Post] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getData(posts: vm.bookmarks)
        setCV()
        setUI()
        bind()
        calendarView.select(Date())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCalendarView {
    
    func getData(posts:[Post]) {
        bookmarkData = []
        calendarData = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        for post in posts {
            if post.applyDate.components(separatedBy: "~").count == 2 {
               let date = post.applyDate.components(separatedBy: "~")
                let prevDate = dateFormatter.date(from: date[0])!
                let nextDate = dateFormatter.date(from: date[1])!
                let range = prevDate...nextDate
                calendarData.updateValue(post, forKey: range)
                if range.contains(Date()) {
                    bookmarkData.append(post)
                }
            } else {
                bookmarkData.append(post)
            }
        }
        DispatchQueue.main.async {
            self.calendarCV.reloadData()
            self.calendarView.reloadData()
            self.refreshControl.endRefreshing()
        }
        
    }
    
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
        
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        calendarCV.refreshControl = refreshControl
        addSubview(calendarCV)
        calendarCV.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-57)
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
            self.calendarView.reloadData()
        }).disposed(by: disposeBag)
        
        rightBt.rx.tap.subscribe(onNext: {
            let _calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.month = 1
            self.calendarView.currentPage = _calendar.date(byAdding: dateComponents, to: self.calendarView.currentPage)!
            self.calendarView.setCurrentPage(self.calendarView.currentPage, animated: true)
            self.setTitle()
            self.calendarView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    func setTitle() {
        let date = calendarView.currentPage
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        let title = dateFormatter.string(from: date)
        titleLb.text = title
    }
    
    @objc func fetchData() {
        let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
        let url = "https://www.makeus-hyun.shop/app/mains/bookmark"
        let header:HTTPHeaders = [ "uid": uid,
                                   "Content-Type":"application/json"]
        vm.bookmarks = []
        AF.request(url, method: .get, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = json["result"].arrayValue
                    for post in result {
                        let postModel = Post(json: post)
                        MainTabViewModel.instance.bookmarks.append(postModel)
                    }
                    self.getData(posts: self.vm.bookmarks)
                case .failure(_):
                    HomeChartViewModel.instance.input.errorObserver.accept(())
                }
            }
    }
    
    
    
}

extension HomeCalendarView: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        var count = 0
        for (k, _) in calendarData {
            if k.contains(date) {
                count += 1
            }
        }
        if count >= 3 { count = 3}
        return count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        for (k, v) in calendarData {
            if k.contains(date) {
                if !bookmarkData.contains(v) {
                    bookmarkData.append(v)
                }
            } else {
                if bookmarkData.contains(v) {
                    let index = bookmarkData.firstIndex(of: v)!
                    bookmarkData.remove(at: index)
                }
            }
        }
        calendarCV.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cellId", for: date, at: position)
        return cell
    }
    
}

extension HomeCalendarView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarkData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CalendarCell
        cell.configure(post: bookmarkData[indexPath.row])
        cell.delegate = self
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomeChartViewModel.instance.input.postObserver.accept(self.bookmarkData[indexPath.row])
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
            $0.height.width.equalTo(31)
            $0.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.top.equalToSuperview().offset(15)
        }
        
        contentView.addSubview(subLb)
        subLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(9)
            $0.leading.equalTo(imgView.snp.trailing).offset(14)
        }
        
        contentView.addSubview(alertImg)
        alertImg.alpha = 0
        alertImg.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-11)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    func configure(post: Post) {
        imgView.image = UIImage().getLogoImage(post.manageOffice)
        titleLb.text = post.name
        subLb.text = post.manageOffice
    }
}


extension HomeCalendarView: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let delete = SwipeAction(style: .default, title: "삭제") { action, indexPath in
            let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
            let url = "https://www.makeus-hyun.shop/app/users/bookmark"
            let header:HTTPHeaders = [ "userUid": uid,
                                       "welfareUid": self.bookmarkData[indexPath.row].uid,
                                       "Content-Type":"application/json"]
            
            self.vm.bookmarks = []
            AF.request(url, method: .post, headers: header)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["isSuccess"].boolValue
                        if result {
                            self.fetchData()
                        }
                    case .failure(_):
                        HomeChartViewModel.instance.input.errorObserver.accept(())
                    }
                }
        }
        
        delete.backgroundColor = UIColor.rgb(red: 255, green: 152, blue: 87)
        delete.image = UIImage(named: "trash")!
        delete.accessibilityContainerType = .none
        
        delete.transitionDelegate = ScaleTransition.default
       
        return [delete]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        
        options.buttonSpacing = 7
        
        return options
    }
    
    
    
}
