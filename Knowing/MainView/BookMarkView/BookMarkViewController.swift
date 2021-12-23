//
//  BookMarkViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//
import UIKit
import Foundation
import Then
import RxCocoa
import RxSwift
import SwipeCellKit
import Alamofire
import SwiftyJSON
import Firebase

class BookMarkViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let searchBar = CustomTextField(image: UIImage(named: "search")!, text: "검색", state: .search)
    
    var defaultOptions = SwipeOptions()
    var buttonStyle: ButtonStyle = .circular
    let vm = MainTabViewModel.instance
    
    
    var filteredData:[Post] = []
    
    let countLb = UILabel().then {
        $0.text = "총 68건"
        $0.textColor = UIColor.rgb(red: 171, green: 171, blue: 171)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    let sortTitle = UILabel().then {
        $0.text = "높은 금액순"
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.alpha = 1
    }
    
    let sortBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "filterImg")!, for: .normal)
        $0.alpha = 1
    }
    
    let bookmarkCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.alpha = 0
        return collectionView
    }()
    
    let noDataImg = UIImageView(image: UIImage(named:"noBookmarkImg"))
    
    let noDataTitleLb = UILabel().then {
        $0.text = "북마크한 게시물이 없습니다."
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    let noDataSubTitleLb = UILabel().then {
        $0.text = "기억해둘 복지는 북마크 아이콘을 눌러서 모아보세요!"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
    }
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.bcObserver.accept(.white)
        setData()
        setUI()
        setCV()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension BookMarkViewController {
    
    func setData() {
        filteredData = vm.bookmarks
        countLb.text = "총 \(vm.bookmarks.count)건"
        if vm.bookmarks.count == 0 {
            noDataImg.alpha = 1.0
            noDataTitleLb.alpha = 1.0
            noDataSubTitleLb.alpha = 1.0
            bookmarkCV.alpha = 0.0
            
        } else {
            noDataImg.alpha = 0.0
            noDataTitleLb.alpha = 0.0
            noDataSubTitleLb.alpha = 0.0
            bookmarkCV.alpha = 1.0
        }
        searchBar.text = ""
    }
    
    func setUI() {
        self.lightMode()
        view.backgroundColor = .white
        safeArea.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(44)
        }
        
        safeArea.addSubview(countLb)
        countLb.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(sortBt)
        sortBt.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        safeArea.addSubview(sortTitle)
        sortTitle.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(26)
            $0.trailing.equalTo(sortBt.snp.leading).offset(-6)
        }
        
        safeArea.addSubview(noDataImg)
        noDataImg.snp.makeConstraints {
            $0.top.equalTo(countLb.snp.bottom).offset(146)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(noDataTitleLb)
        noDataTitleLb.snp.makeConstraints {
            $0.top.equalTo(noDataImg.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(noDataSubTitleLb)
        noDataSubTitleLb.snp.makeConstraints {
            $0.top.equalTo(noDataTitleLb.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        bookmarkCV.refreshControl = refreshControl
        safeArea.addSubview(bookmarkCV)
        bookmarkCV.snp.makeConstraints {
            $0.top.equalTo(countLb.snp.bottom).offset(17)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        bookmarkCV.reloadData()
    }
    
    
    func setCV() {
        bookmarkCV.dataSource = self
        bookmarkCV.delegate = self
        bookmarkCV.register(PostCell.self, forCellWithReuseIdentifier: "cellId")
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
                    DispatchQueue.main.async {
                        self.setData()
                        self.bookmarkCV.reloadData()
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
    
    func bind() {
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) //0.5초 기다림
            .distinctUntilChanged() // 같은 아이템을 받지 않는기능
            .subscribe(onNext: { t in self.filteredData = self.vm.bookmarks.filter{ $0.name.hasPrefix(t) }
                self.bookmarkCV.reloadData()
            })
            .disposed(by: disposeBag)
        
        sortBt.rx.tap.subscribe(onNext: {
            
            //            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            //
            //            let maxMoneySort = UIAlertAction(title: "높은 금액순", style: .default) { _ in
            //                self.vm.bookmarks.sort(by: { a, b in
            //                    return Int(a.maxMoney)! > Int(b.maxMoney)!
            //                })
            //                self.sortTitle.text = "높은 금액순"
            //                self.bookmarkCV.reloadData()
            //            }
            //
            //            let minMoneySort = UIAlertAction(title: "낮은 금액순", style: .default) { _ in
            //                self.vm.bookmarks.sort(by: { a, b in
            //                    return Int(a.maxMoney)! < Int(b.maxMoney)!
            //                })
            //                self.sortTitle.text = "낮은 금액순"
            //                self.bookmarkCV.reloadData()
            //            }
            //
            //            let lastestDateSort = UIAlertAction(title: "마감 일순", style: .default) { _ in
            //                self.vm.bookmarks.sort(by: { prev, next in
            //                    let prevTmp = prev.applyDate.components(separatedBy: "~")
            //                    let nextTmp = next.applyDate.components(separatedBy: "~")
            //
            //                    let prevDate = prevTmp.count == 2 ? Int(prevTmp[1].replacingOccurrences(of: ".", with: "")) ?? 0 : 99999999
            //                    let nextDate = nextTmp.count == 2 ? Int(nextTmp[1].replacingOccurrences(of: ".", with: "")) ?? 0 : 99999999
            //
            //                    return prevDate < nextDate
            //                })
            //                self.sortTitle.text = "마감 일순"
            //                self.bookmarkCV.reloadData()
            //            }
            //
            //            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            //
            //            }
            //
            //
            //            actionSheet.addAction(maxMoneySort)
            //            actionSheet.addAction(minMoneySort)
            //            actionSheet.addAction(lastestDateSort)
            //            actionSheet.addAction(cancelAction)
            //
            //            self.present(actionSheet, animated: true, completion: nil)
            
            let vc = SortViewController()
            self.presentPanModal(vc)
            
            
        }).disposed(by: disposeBag)
        
        vm.output.sortValue.subscribe(onNext: { value in
            
            switch value {
            case .lastestDate:
                self.vm.bookmarks.sort(by: { prev, next in
                    let prevTmp = prev.applyDate.components(separatedBy: "~")
                    let nextTmp = next.applyDate.components(separatedBy: "~")
                    
                    let prevDate = prevTmp.count == 2 ? Int(prevTmp[1].replacingOccurrences(of: ".", with: "")) ?? 0 : 99999999
                    let nextDate = nextTmp.count == 2 ? Int(nextTmp[1].replacingOccurrences(of: ".", with: "")) ?? 0 : 99999999
                    
                    return prevDate < nextDate
                })
                self.sortTitle.text = "마감 일순"
                self.bookmarkCV.reloadData()
            case .maxMoney:
                self.vm.bookmarks.sort(by: { a, b in
                    return Int(a.maxMoney)! > Int(b.maxMoney)!
                })
                self.sortTitle.text = "높은 금액순"
                self.bookmarkCV.reloadData()
            case .minMoney:
                self.vm.bookmarks.sort(by: { prev, next in
                    let prevTmp = prev.applyDate.components(separatedBy: "~")
                    let nextTmp = next.applyDate.components(separatedBy: "~")
                    
                    let prevDate = prevTmp.count == 2 ? Int(prevTmp[1].replacingOccurrences(of: ".", with: "")) ?? 0 : 99999999
                    let nextDate = nextTmp.count == 2 ? Int(nextTmp[1].replacingOccurrences(of: ".", with: "")) ?? 0 : 99999999
                    
                    return prevDate < nextDate
                })
                self.sortTitle.text = "마감 일순"
                self.bookmarkCV.reloadData()
            }
            
        }).disposed(by: disposeBag)
        
    }
    
}


extension BookMarkViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PostCell
        cell.delegate = self
        cell.contentView.backgroundColor = UIColor.rgb(red: 255, green: 246, blue: 232)
        cell.contentView.layer.cornerRadius = 30
        cell.configure(filteredData[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let post = filteredData[indexPath.row]
        let vm = PostDetailViewModel(post)
        let vc = PostDetailViewController(vm: vm)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 40
        return CGSize(width: width, height: 133)
    }
    
}

extension BookMarkViewController: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let delete = SwipeAction(style: .default, title: "삭제") { action, indexPath in
            let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
            let url = "https://www.makeus-hyun.shop/app/users/bookmark"
            let welfareUid = self.filteredData[indexPath.row].uid
            let header:HTTPHeaders = [ "userUid": uid,
                                       "welfareUid": welfareUid,
                                       "Content-Type":"application/json"]
            
            AF.request(url, method: .post, headers: header)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["isSuccess"].boolValue
                        if result {
                            self.vm.bookmarks = []
                            self.fetchData()
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
