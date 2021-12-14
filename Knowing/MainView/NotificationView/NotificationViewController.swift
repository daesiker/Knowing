//
//  NotificationViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then
import SwipeCellKit
import Alamofire
import SwiftyJSON
import Firebase
import RxSwift
import RxCocoa

class NotificationViewController: UIViewController {

    let vm = MainTabViewModel.instance
    var disposeBag = DisposeBag()
    let titleLb = UILabel().then {
        $0.text = "알림"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "GodoM", size: 26)
    }
    var readData:[GetAlarmList] = []
    var unreadData:[GetAlarmList] = []
    
    
    let subTitleLb = UILabel().then {
        $0.text = "읽지 않은 알림"
        $0.textColor = UIColor.rgb(red: 135, green: 135, blue: 135)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)
    }
    
    let removeBt = RemoveButton()
    
    let countLb = PaddingLabel().then {
        $0.text = "0건"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.backgroundColor = UIColor.rgb(red: 255, green: 142, blue: 59)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 14
        $0.topInset = 7
        $0.bottomInset = 7
        $0.leftInset = 8
        $0.rightInset = 8
    }
    
    let notificationCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    let noAlarmImgView = UIImageView(image: UIImage(named: "noAlarm")!).then {
        $0.alpha = 0
    }
    
    let noAlarmTitleLb = UILabel().then {
        $0.text = "알람 설정한 게시물이 없습니다."
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.alpha = 0
    }
    
    let noAlarmSubTitleLb = UILabel().then {
        $0.text = "기억해둘 복지에 알림 아이콘을 눌러 두면\n신청 마감일이 다가왔을 때 알림을 드려요!"
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.numberOfLines = 2
        $0.alpha = 0
    }
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainTabViewModel.instance.bcObserver.accept(.white)
        setCV()
        setUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension NotificationViewController {
    
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(subTitleLb)
        subTitleLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(countLb)
        countLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(8)
            $0.leading.equalTo(subTitleLb.snp.trailing).offset(12)
        }
        
        safeArea.addSubview(removeBt)
        removeBt.snp.makeConstraints {
            $0.top.equalTo(countLb.snp.bottom).offset(11)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        notificationCV.refreshControl = refreshControl
        safeArea.addSubview(notificationCV)
        notificationCV.snp.makeConstraints {
            $0.top.equalTo(removeBt.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        safeArea.addSubview(noAlarmImgView)
        noAlarmImgView.snp.remakeConstraints {
            $0.top.equalTo(countLb.snp.bottom).offset(129)
            $0.centerX.equalToSuperview()
        }

        safeArea.addSubview(noAlarmTitleLb)
        noAlarmTitleLb.snp.remakeConstraints {
            $0.top.equalTo(noAlarmImgView.snp.bottom).offset(19.2)
            $0.centerX.equalToSuperview()
        }

        safeArea.addSubview(noAlarmSubTitleLb)
        noAlarmSubTitleLb.snp.remakeConstraints {
            $0.top.equalTo(noAlarmTitleLb.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(232)
        }
    }
    
    func fetchedData() {
        
        if readData.count == 0 && unreadData.count == 0 {
            removeBt.alpha = 0
            notificationCV.alpha = 0
            noAlarmImgView.alpha = 1
            noAlarmTitleLb.alpha = 1
            noAlarmSubTitleLb.alpha = 1
        } else {
            removeBt.alpha = 1
            notificationCV.alpha = 1
            noAlarmImgView.alpha = 0
            noAlarmTitleLb.alpha = 0
            noAlarmSubTitleLb.alpha = 0
        }
    }
    
    func setCV() {
        notificationCV.delegate = self
        notificationCV.dataSource = self
        notificationCV.register(NotificationCell.self, forCellWithReuseIdentifier: "unreadId")
        notificationCV.register(AlarmSeparatorCell.self, forCellWithReuseIdentifier: "separCell")
        notificationCV.register(NotificationCell.self, forCellWithReuseIdentifier: "readId")
    }
    
    func bind() {
        removeBt.rx.tap.subscribe(onNext: {
            let url = "https://www.makeus-hyun.shop/app/mains/alarm/alarmPage/total"
            let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
            let header:HTTPHeaders = ["userUid": uid,
                                      "Content-Type":"application/json"]
            
            AF.request(url, method: .delete, headers: header)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["isSuccess"].boolValue
                        if result {
                            self.countLb.text = "0건"
                            self.unreadData = []
                            self.readData = []
                            self.fetchedData()
                        } else {
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "에러", message: "잠시후에 다시 시도해주세요.", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
                                self.present(alertController, animated: true)
                            }
                        }
                    case .failure(_):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "에러", message: "네트워크 연결상태를 확인해주세요.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
                            self.present(alertController, animated: true)
                        }
                    }
                }
            
        }).disposed(by: disposeBag)
        
        refreshControl.addTarget(self, action: #selector(getData), for: .valueChanged)
        
    }
    
   @objc func getData() {
        let url = "https://www.makeus-hyun.shop/app/mains/alarm/alarmPage"
        let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
        let header:HTTPHeaders = ["userUid": uid,
                      "Content-Type":"application/json"]
        
        AF.request(url, method: .get, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = json["result"].dictionaryValue
                    let result = data["alarm"]!.arrayValue
                    self.readData = []
                    self.unreadData = []
                    
                    for alarm in result {
                        let alarmModel = GetAlarmList(json: alarm)
                        if alarmModel.alarmRead {
                            self.unreadData.append(alarmModel)
                        } else {
                            self.readData.append(alarmModel)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.countLb.text = "\(self.unreadData.count)건"
                        self.notificationCV.reloadData()
                        self.fetchedData()
                        self.refreshControl.endRefreshing()
                    }
                    
                case .failure(_):
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "에러", message: "네트워크 연결상태를 확인해주세요.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
                        self.present(alertController, animated: true)
                    }
                }
            }
        
        
    }
    
}

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if unreadData.count != 0 && readData.count != 0 {
            if section == 0 {
               return unreadData.count
            } else if section == 1 {
                return 1
            } else {
                return readData.count
            }
        } else {
            if unreadData.count == 0 {
                return readData.count
            } else {
                return unreadData.count
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if unreadData.count != 0 && readData.count != 0 {
            return 3
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = "https://www.makeus-hyun.shop/app/mains/welfareInfo"
        var uid = ""
        var header:HTTPHeaders = []
        if unreadData.count != 0 && readData.count != 0 {
            if indexPath.section == 0{
                uid = unreadData[indexPath.row].postUid
                header = ["uid": uid,
                        "Content-Type":"application/json"]
            } else {
                uid = readData[indexPath.row].postUid
                header = ["uid": uid,
                        "Content-Type":"application/json"]
            }
            
            
        } else {
            if unreadData.count == 0 {
                uid = readData[indexPath.row].postUid
                header = ["uid": uid,
                        "Content-Type":"application/json"]
            } else {
                uid = unreadData[indexPath.row].postUid
                header = ["uid": uid,
                        "Content-Type":"application/json"]
            }
        }
        
        AF.request(url, method: .get, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = json["result"]
                    let post = Post(json: result)
                    DispatchQueue.main.async {
                        let vm = PostDetailViewModel(post)
                        let vc = PostDetailViewController(vm: vm)
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "에러", message: "네트워크 연결상태를 확인해주세요.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
                        self.present(alertController, animated: true)
                    }
                }
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if unreadData.count != 0 && readData.count != 0 {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unreadId", for: indexPath) as! NotificationCell
                cell.configure(unreadData[indexPath.row])
                cell.delegate = self
                return cell
            } else if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "separCell", for: indexPath) as! AlarmSeparatorCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "readId", for: indexPath) as! NotificationCell
                cell.configure(readData[indexPath.row])
                cell.delegate = self
                return cell
            }
        } else {
            if unreadData.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "readId", for: indexPath) as! NotificationCell
                cell.configure(readData[indexPath.row])
                cell.delegate = self
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unreadId", for: indexPath) as! NotificationCell
                cell.configure(unreadData[indexPath.row])
                cell.delegate = self
                return cell
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width - 40
        if unreadData.count != 0 && readData.count != 0 {
            if indexPath.section == 0 {
                if unreadData[indexPath.row].subTitle.count <= 24 {
                    return CGSize(width: width, height: 107)
                } else {
                    return CGSize(width: width, height: 125)
                }
                
            } else if indexPath.section == 1 {
                return CGSize(width: width, height: 1)
            } else {
                if readData[indexPath.row].subTitle.count <= 24 {
                    return CGSize(width: width, height: 107)
                } else {
                    return CGSize(width: width, height: 125)
                }
            }
        } else {
            if unreadData.count == 0 {
                if readData[indexPath.row].subTitle.count <= 24 {
                    return CGSize(width: width, height: 107)
                } else {
                    return CGSize(width: width, height: 125)
                }
            } else {
                if unreadData[indexPath.row].subTitle.count <= 24 {
                    return CGSize(width: width, height: 107)
                } else {
                    return CGSize(width: width, height: 125)
                }
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 20)
    }

}

extension NotificationViewController: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let delete = SwipeAction(style: .default, title: "삭제") { action, indexPath in
            let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
            let url = "https://www.makeus-hyun.shop/app/mains/alarm/alarmPage"
            
            let welfareUid = indexPath.section == 0 ? self.unreadData[indexPath.row].uid : self.readData[indexPath.row].uid
            
            let header:HTTPHeaders = [ "userUid": uid,
                                       "alarmUid": welfareUid,
                                       "Content-Type":"application/json"]
            
            self.vm.bookmarks = []
            AF.request(url, method: .delete, headers: header)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let data = json["result"].dictionaryValue
                        if let result = data["alarm"]?.arrayValue {
                            self.unreadData = []
                            self.readData = []
                            for alarm in result {
                                let alarmModel = GetAlarmList(json: alarm)
                                if alarmModel.alarmRead {
                                    self.unreadData.append(alarmModel)
                                } else {
                                    self.readData.append(alarmModel)
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.countLb.text = "\(self.unreadData.count)건"
                                self.notificationCV.reloadData()
                                self.fetchedData()
                            }
                        } else {
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "에러", message: "잠시후에 다시 시도해주세요.", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
                                self.present(alertController, animated: true)
                            }
                        }
                    
                    case .failure(_):
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "에러", message: "네트워크 연결상태를 확인해주세요.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
                            self.present(alertController, animated: true)
                        }
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



class RemoveButton: UIButton {
    
    let image = UIImageView(image: UIImage(named: "trashA")!)
    let title = UILabel().then {
        $0.text = "전체 삭제"
        $0.textColor = UIColor.rgb(red: 166, green: 166, blue: 166)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        image.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-7)
            $0.leading.equalToSuperview().offset(8)
        }
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(5)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class NotificationCell: SwipeCollectionViewCell {
    
    let titleLb = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let subTitleLb = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.numberOfLines = 2
    }
    
    let dateLb = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)
        $0.textColor = UIColor.rgb(red: 148, green: 148, blue: 148)
    }
    
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
        layer.cornerRadius = 30
    }
    
    func setupView() {
        backgroundColor = .clear
        
        contentView.layer.cornerRadius = 30
        contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
        }
        
        contentView.addSubview(subTitleLb)
        subTitleLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
        }
        
        contentView.addSubview(dateLb)
        dateLb.snp.makeConstraints {
            $0.top.equalTo(subTitleLb.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(18)
        }
        
    }
    
    func configure(_ alarm: GetAlarmList) {
        
        titleLb.text = alarm.title
        subTitleLb.text = alarm.subTitle
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        let date = dateFormatter.date(from: alarm.date)
        dateLb.text = date?.timeAgoDisplay()
        
        if alarm.alarmRead == false {
            contentView.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
            titleLb.textColor = UIColor.rgb(red: 116, green: 116, blue: 116)
            subTitleLb.textColor = UIColor.rgb(red: 155, green: 155, blue: 155)
        } else {
            contentView.backgroundColor = UIColor.rgb(red: 255, green: 246, blue: 232)
            titleLb.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
            subTitleLb.textColor = UIColor.rgb(red: 206, green: 142, blue: 98)
            
            
        }
        
    }
    
}

class AlarmSeparatorCell: UICollectionViewCell {
    
    let view = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
