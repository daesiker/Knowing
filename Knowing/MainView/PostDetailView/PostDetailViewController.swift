//
//  PostDetailViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/25.
//

import UIKit
import RxCocoa
import RxSwift


class PostDetailViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let scrollView = UIScrollView(frame: .zero).then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.frame = UIScreen.main.bounds
        $0.backgroundColor = .white
        
    }
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let alarmBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "docDetail_alarm"), for: .normal)
    }
    
    let bookmarkBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "docDetail_bookmark"), for: .normal)
    }
    
    let shareBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "docDetail_share"), for: .normal)
    }
    
    let logoImg = UIImageView(image: UIImage(named: "goLogo")!)
    
    let nameLb = UILabel().then {
        $0.text = "고용노동부"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 118, green: 118, blue: 118)
    }
    
    let titleLb = UILabel().then {
        $0.text = "국민취업지원제도"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        $0.textAlignment = .left
        $0.textColor = UIColor.rgb(red: 65, green: 63, blue: 81)
    }
    
    let detailLb = UILabel().then {
        $0.text = "한국형 실업부조로 고용안전망 사각지대에 있는 취업취약계층에게 취업지원서비스 및 생활안정을 지원하는 정책"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        $0.textColor = UIColor.rgb(red: 161, green: 161, blue: 161)
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
    }
    
    let largeCategoryLb = PaddingLabel().then {
        $0.text = "취업지원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        $0.textColor = UIColor.rgb(red: 233, green: 148, blue: 95)
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        
    }
    
    let smallCategoryLb = PaddingLabel().then {
        $0.text = "구직 활동 지원 · 인턴"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        $0.textColor = UIColor.rgb(red: 233, green: 148, blue: 95)
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let mainStackView = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 247, blue: 235)
        $0.layer.cornerRadius = 20
    }
    
    let serviceTitle = UILabel().then {
        $0.text = "지원형태"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    let dDayTitle = UILabel().then {
        $0.text = "디데이"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    let peopleTitle = UILabel().then {
        $0.text = "선정인원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    let serviceValue = UILabel().then {
        $0.text = "현금"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
    }
    
    let dDayValue = UILabel().then {
        $0.text = "D-20"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
    }
    
    let peopleValue = UILabel().then {
        $0.text = "590,000명"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
    }
    
    let separatorOne = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let scrollOffsetView = UIView()
    
    let contentsBt = ScrollButton("지원 내용", isInit: true)
    
    let conditionBt = ScrollButton("신청 자격")
    
    let methodBt = ScrollButton("신청 방법")
    
    let etcBt = ScrollButton("기타")
    
    let howMuchTitle = DetailTitleLabel("얼마나 받을 수 있나요?", image: UIImage(named: "docDetail_money")!)
    
    let maxTitleLb = UILabel().then {
        $0.text = "최대"
        $0.textColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
    }
    
    let maxMoneyLb = UILabel().then {
        $0.text = "3,000,000"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        $0.textColor = UIColor.rgb(red: 255, green: 136, blue: 84)
    }
    
    let wonLb = UILabel().then {
        $0.text = "원"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        $0.textColor = UIColor.rgb(red: 255, green: 136, blue: 84)
    }
    
    let minTitleLb = UILabel().then {
        $0.text = "최소"
        $0.textColor = UIColor.rgb(red: 66, green: 66, blue: 66)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)
    }
    
    let minMoneyLb = UILabel().then {
        $0.text = "조건별 상이"
        $0.textColor = UIColor.rgb(red: 66, green: 66, blue: 66)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)
        $0.textAlignment = .left
    }
    
    let separatorTwo = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let benefitTitle = DetailTitleLabel("어떤 혜택을 받을 수 있나요?", image: UIImage(named: "docDetail_benefit")!)
    
    var benefitsLabels:[UIView] = []
    
    let separatorThree = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let howPeopleTitle = DetailTitleLabel("누가 받을 수 있나요?", image: UIImage(named: "docDetail_people")!)
    
    let peopleDetailTitle = UILabel().then {
        $0.text = "신청 자격 요약"
        $0.textColor = UIColor.rgb(red: 163, green: 163, blue: 163)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let peopleWarningImg = UIImageView(image: UIImage(named: "docDetail_warning")!)
    
    let peopleDetailBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "docDetail_close")!, for: .normal)
    }
    
    let separatorFour = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
    }
    
    let peopleDetailView = PeopleDetailView()
    
    let separatorFive = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 250, green: 239, blue: 221)
    }
    
    let restinctTitle = UnderLineLabel("참여 제한 대상")
    
    var restinctLabels:[UIView] = []
    
    let separatorSix = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let howApplyTitle = DetailTitleLabel("어떻게 신청하나요?", image: UIImage(named: "docDetail_pencil")!)
    
    let applyDateTitle = UnderLineLabel("신청·운영 기간")
    
    let applyStartDateTitle = UILabel().then {
        $0.text = "신청 시작일"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let applyEndDateTitle = UILabel().then {
        $0.text = "신청 마감일"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let operationDateTitle = UILabel().then {
        $0.text = "복지 운영 기간"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let applyStartDateValue = UILabel().then {
        $0.text = "2020.12.18"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
    }
    
    let applyEndDateValue = UILabel().then {
        $0.text = "-"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
    }
    
    let operationDateValue = UILabel().then {
        $0.text = "연중 상시"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
    }
    
    let separatorSeven = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 250, green: 239, blue: 221)
    }
    
    let applyHowTitle = UnderLineLabel("신청 방법")
    
    var applyHowValues:[ApplyHowValueLabel] = []
    
    
    let separatorEight = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 250, green: 239, blue: 221)
    }
    
    let applyAuditTitle = UnderLineLabel("심사 및 발표")
    
    var applyAuditValues:[ApplyAuditTitle] = []
    
    let separatorNine = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 250, green: 239, blue: 221)
    }
    
    let applyDocTitle = UnderLineLabel("제출 서류")
    
    var applyDocValues:[ApplyDocTitle] = []
    
    let separatorTen = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let howEtcTitle = DetailTitleLabel("기타 정보", image: UIImage(named: "docDetail_etc")!)
    
    let etcPhNumTitle = UILabel().then {
        $0.text = "문의 전화"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let etcOperationTitle = UILabel().then {
        $0.text = "운영 기관"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let etcPhNumValue = UILabel().then {
        $0.text = "1350"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textAlignment = .left
    }
    
    let etcPhNumSubValue = UILabel().then {
        $0.text = "고용센터"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textAlignment = .left
    }
    
    let etcOperationValue = UILabel().then {
        $0.text = "1350"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.textAlignment = .left
    }
    
    let goToWebBt = UIButton(type: .custom).then {
        $0.setTitle("신청 홈페이지 바로가기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 14, left: 91, bottom: 15, right: 89)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    
}


extension PostDetailViewController {
    
    func setUI() {
        view.backgroundColor = .white
        safeArea.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(shareBt)
        shareBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
        
        scrollView.addSubview(bookmarkBt)
        bookmarkBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalTo(shareBt.snp.leading).offset(-10)
        }
        
        scrollView.addSubview(alarmBt)
        alarmBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalTo(bookmarkBt.snp.leading).offset(-10)
        }
        
        scrollView.addSubview(logoImg)
        logoImg.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(nameLb)
        nameLb.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(27)
            $0.leading.equalTo(logoImg.snp.trailing).offset(13)
        }
        
        scrollView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalTo(nameLb.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-19)
        }
        
        scrollView.addSubview(detailLb)
        detailLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
        
        scrollView.addSubview(largeCategoryLb)
        largeCategoryLb.snp.makeConstraints {
            $0.top.equalTo(detailLb.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(smallCategoryLb)
        smallCategoryLb.snp.makeConstraints {
            $0.top.equalTo(detailLb.snp.bottom).offset(26)
            $0.leading.equalTo(largeCategoryLb.snp.trailing).offset(8)
        }
        
        scrollView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(largeCategoryLb.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-19)
            $0.height.equalTo(80)
        }
        
        mainStackView.addSubview(serviceTitle)
        serviceTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(38)
            $0.top.equalToSuperview().offset(19)
        }
        
        mainStackView.addSubview(dDayTitle)
        dDayTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.centerX.equalToSuperview()
        }
        
        mainStackView.addSubview(peopleTitle)
        peopleTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-38)
        }
        
        mainStackView.addSubview(serviceValue)
        serviceValue.snp.makeConstraints {
            $0.top.equalTo(serviceTitle.snp.bottom).offset(10)
            $0.centerX.equalTo(serviceTitle.snp.centerX)
        }
        
        mainStackView.addSubview(dDayValue)
        dDayValue.snp.makeConstraints {
            $0.top.equalTo(dDayTitle.snp.bottom).offset(10)
            $0.centerX.equalTo(dDayTitle.snp.centerX)
        }
        
        mainStackView.addSubview(peopleValue)
        peopleValue.snp.makeConstraints {
            $0.top.equalTo(peopleTitle.snp.bottom).offset(10)
            $0.centerX.equalTo(peopleTitle.snp.centerX)
        }
        
        scrollView.addSubview(separatorOne)
        separatorOne.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.top.equalTo(mainStackView.snp.bottom).offset(20)
            $0.height.equalTo(6)
        }
        
        scrollView.addSubview(scrollOffsetView)
        scrollOffsetView.snp.makeConstraints {
            $0.top.equalTo(separatorOne.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.height.equalTo(59)
        }
        
        scrollOffsetView.addSubview(contentsBt)
        contentsBt.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(view.frame.width / 4)
            $0.height.equalTo(59)
        }
        
        scrollOffsetView.addSubview(conditionBt)
        conditionBt.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(contentsBt.snp.trailing)
            $0.width.equalTo(view.frame.width / 4)
            $0.height.equalTo(59)
        }
        
        scrollOffsetView.addSubview(methodBt)
        methodBt.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(conditionBt.snp.trailing)
            $0.width.equalTo(view.frame.width / 4)
            $0.height.equalTo(59)
        }
        
        scrollOffsetView.addSubview(etcBt)
        etcBt.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(methodBt.snp.trailing)
            $0.width.equalTo(view.frame.width / 4)
            $0.height.equalTo(59)
        }
        
        scrollView.addSubview(howMuchTitle)
        howMuchTitle.snp.makeConstraints {
            $0.top.equalTo(scrollOffsetView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.height.equalTo(33)
        }
        
        scrollView.addSubview(maxTitleLb)
        maxTitleLb.snp.makeConstraints {
            $0.top.equalTo(howMuchTitle.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(20)
           
        }
        
        scrollView.addSubview(maxMoneyLb)
        maxMoneyLb.snp.makeConstraints {
            $0.top.equalTo(howMuchTitle.snp.bottom).offset(24)
            $0.leading.equalTo(maxTitleLb.snp.trailing).offset(18)
        }
        
        scrollView.addSubview(wonLb)
        wonLb.snp.makeConstraints {
            $0.top.equalTo(howMuchTitle.snp.bottom).offset(27)
            $0.leading.equalTo(maxMoneyLb.snp.trailing).offset(2)
        }
        
        scrollView.addSubview(minTitleLb)
        minTitleLb.snp.makeConstraints {
            $0.top.equalTo(maxTitleLb.snp.bottom).offset(17)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(32)
        }
        
        scrollView.addSubview(minMoneyLb)
        minMoneyLb.snp.makeConstraints {
            $0.top.equalTo(maxTitleLb.snp.bottom).offset(17)
            $0.leading.equalTo(minTitleLb.snp.trailing).offset(18)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
        
        scrollView.addSubview(separatorTwo)
        separatorTwo.snp.makeConstraints {
            $0.top.equalTo(minTitleLb.snp.bottom).offset(27)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.height.equalTo(6)
        }
        
        scrollView.addSubview(benefitTitle)
        benefitTitle.snp.makeConstraints {
            $0.top.equalTo(separatorTwo.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.height.equalTo(33)
        }
        
        getbenefitLabel()
        
        scrollView.addSubview(separatorThree)
        separatorThree.snp.makeConstraints {
            $0.top.equalTo(benefitsLabels.last!.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.height.equalTo(6)
        }
        
        scrollView.addSubview(howPeopleTitle)
        howPeopleTitle.snp.makeConstraints {
            $0.top.equalTo(separatorThree.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.height.equalTo(33)
        }
        
        scrollView.addSubview(peopleDetailTitle)
        peopleDetailTitle.snp.makeConstraints {
            $0.top.equalTo(howPeopleTitle.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(84)
        }
        
        scrollView.addSubview(peopleWarningImg)
        peopleWarningImg.snp.makeConstraints {
            $0.top.equalTo(howPeopleTitle.snp.bottom).offset(27)
            $0.leading.equalTo(peopleDetailTitle.snp.trailing)
        }
        
        scrollView.addSubview(peopleDetailBt)
        peopleDetailBt.snp.makeConstraints {
            $0.top.equalTo(howPeopleTitle.snp.bottom).offset(27)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
        
        
        scrollView.addSubview(separatorFour)
        separatorFour.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(peopleDetailTitle.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-19)
        }
        
        scrollView.addSubview(peopleDetailView)
        peopleDetailView.snp.makeConstraints {
            $0.top.equalTo(separatorFour.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea.snp.trailing)
        }
        
        scrollView.addSubview(separatorFive)
        separatorFive.snp.makeConstraints {
            $0.top.equalTo(separatorFour.snp.bottom).offset(280)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.height.equalTo(1)
        }
        
        scrollView.addSubview(restinctTitle)
        restinctTitle.snp.makeConstraints {
            $0.top.equalTo(separatorFive.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
        }
        
        getRestinctLabel()
        
        scrollView.addSubview(separatorSix)
        separatorSix.snp.makeConstraints {
            $0.top.equalTo(restinctLabels.last!.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.height.equalTo(6)
        }
        
        scrollView.addSubview(howApplyTitle)
        howApplyTitle.snp.makeConstraints {
            $0.top.equalTo(separatorSix.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.height.equalTo(33)
        }
        
        scrollView.addSubview(applyDateTitle)
        applyDateTitle.snp.makeConstraints {
            $0.top.equalTo(howApplyTitle.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(19)
        }
        
        scrollView.addSubview(applyStartDateTitle)
        applyStartDateTitle.snp.makeConstraints {
            $0.top.equalTo(applyDateTitle.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(applyStartDateValue)
        applyStartDateValue.snp.makeConstraints {
            $0.top.equalTo(applyDateTitle.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(125)
        }
        
        scrollView.addSubview(applyEndDateTitle)
        applyEndDateTitle.snp.makeConstraints {
            $0.top.equalTo(applyStartDateTitle.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(applyEndDateValue)
        applyEndDateValue.snp.makeConstraints {
            $0.top.equalTo(applyStartDateValue.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(125)
        }
        
        scrollView.addSubview(operationDateTitle)
        operationDateTitle.snp.makeConstraints {
            $0.top.equalTo(applyEndDateTitle.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(operationDateValue)
        operationDateValue.snp.makeConstraints {
            $0.top.equalTo(applyEndDateValue.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(125)
        }
        
        scrollView.addSubview(separatorSeven)
        separatorSeven.snp.makeConstraints {
            $0.top.equalTo(operationDateTitle.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-19)
            $0.height.equalTo(1)
        }
        
        scrollView.addSubview(applyHowTitle)
        applyHowTitle.snp.makeConstraints {
            $0.top.equalTo(separatorSeven.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(19)
        }
        
        getApplyHowLabel()
        
        scrollView.addSubview(separatorEight)
        separatorEight.snp.makeConstraints {
            $0.top.equalTo(applyHowValues.last!.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-19)
            $0.height.equalTo(1)
        }
        
        scrollView.addSubview(applyAuditTitle)
        applyAuditTitle.snp.makeConstraints {
            $0.top.equalTo(separatorEight.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(19)
        }
        
        getApplyAuditLabel()
        
        scrollView.addSubview(separatorNine)
        separatorNine.snp.makeConstraints {
            $0.top.equalTo(applyAuditValues.last!.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-19)
            $0.height.equalTo(1)
        }
        
        scrollView.addSubview(applyDocTitle)
        applyDocTitle.snp.makeConstraints {
            $0.top.equalTo(separatorNine.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(19)
        }
        
        getApplyDocLabel()
        
        scrollView.addSubview(separatorTen)
        separatorTen.snp.makeConstraints {
            $0.top.equalTo(applyDocValues.last!.snp.bottom).offset(26)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.height.equalTo(6)
        }
        
        scrollView.addSubview(howEtcTitle)
        howEtcTitle.snp.makeConstraints {
            $0.top.equalTo(separatorTen.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.height.equalTo(33)
        }
        
        scrollView.addSubview(etcPhNumTitle)
        etcPhNumTitle.snp.makeConstraints {
            $0.top.equalTo(howEtcTitle.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(etcPhNumValue)
        etcPhNumValue.snp.makeConstraints {
            $0.top.equalTo(howEtcTitle.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(125)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
        
        scrollView.addSubview(etcPhNumSubValue)
        etcPhNumSubValue.snp.makeConstraints {
            $0.top.equalTo(etcPhNumValue.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(125)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
        
        scrollView.addSubview(etcOperationTitle)
        etcOperationTitle.snp.makeConstraints {
            $0.top.equalTo(etcPhNumTitle.snp.bottom).offset(44)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(etcOperationValue)
        etcOperationValue.snp.makeConstraints {
            $0.top.equalTo(etcPhNumSubValue.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(125)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
        
        scrollView.addSubview(goToWebBt)
        goToWebBt.snp.makeConstraints {
            $0.top.equalTo(etcOperationValue.snp.bottom).offset(30)
            $0.centerX.equalTo(safeArea.snp.centerX)
        }
        
        scrollView.layoutIfNeeded()
        
        scrollView.updateContentSize()
        
    }
    
    func getbenefitLabel() {
        let component = ["취업취약계층에 취업지원이 되는데 2줄이 넘어야 하는 경우 어떻게 보이는지 예시로 쓴 글", "저소득층 소득지원 강화", "취업지원서비스 내실화", "구직활동 이행확보", "기존 취업지원 서비스 통합운영"]
        
        for i in 0..<component.count {
            let label = SubTitleLabel(component[i])
            benefitsLabels.append(label)
            scrollView.addSubview(benefitsLabels[i])
            if i == 0 {
                benefitsLabels[i].snp.makeConstraints {
                    $0.top.equalTo(benefitTitle.snp.bottom).offset(32)
                    $0.leading.equalToSuperview().offset(20)
                    $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
                }
            } else {
                benefitsLabels[i].snp.makeConstraints {
                    $0.top.equalTo(benefitsLabels[i-1].snp.bottom)
                    $0.leading.equalToSuperview().offset(20)
                    $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
                }
            }
            
        }
    }
    
    func getRestinctLabel() {
        let component = ["취업취약계층에 취업지원이 되는데 2줄이 넘어야 하는 경우 어떻게 보이는지 예시로 쓴 글", "저소득층 소득지원 강화", "취업지원서비스 내실화", "구직활동 이행확보", "기존 취업지원 서비스 통합운영"]
        
        for i in 0..<component.count {
            let label = SubTitleLabel(component[i])
            restinctLabels.append(label)
            scrollView.addSubview(restinctLabels[i])
            if i == 0 {
                restinctLabels[i].snp.makeConstraints {
                    $0.top.equalTo(restinctTitle.snp.bottom).offset(29)
                    $0.leading.equalToSuperview().offset(20)
                    $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
                }
            } else {
                restinctLabels[i].snp.makeConstraints {
                    $0.top.equalTo(restinctLabels[i-1].snp.bottom)
                    $0.leading.equalToSuperview().offset(20)
                    $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
                }
            }
            
        }
    }
    
    func getApplyHowLabel() {
        let value = ["방문 신청", "온라인 신청"]
        
        for i in 0..<value.count {
            let label = ApplyHowValueLabel(value[i])
            applyHowValues.append(label)
            scrollView.addSubview(label)
            if i == 0 {
                applyHowValues[i].snp.makeConstraints {
                    $0.top.equalTo(applyHowTitle.snp.bottom).offset(18)
                    $0.leading.equalToSuperview().offset(20)
                    $0.height.equalTo(17)
                }
            } else {
                applyHowValues[i].snp.makeConstraints {
                    $0.top.equalTo(applyHowTitle.snp.bottom).offset(18)
                    $0.leading.equalTo(applyHowValues[i-1].snp.trailing).offset(20)
                    $0.height.equalTo(17)
                }
            }
        }
    }
    
    func getApplyAuditLabel() {
        let value = ["신청 (워크넷 구직신청, 취업지원 신청서 제출)", "수급자격 결정 및 통보 (신청서 제출일 이후 1개월 이내)", "취업활동계획수립 (진로상담, 직업심리검사 등 실시)", "1차 구직촉진수당 지급 (신청서 제출 이후 14일 이내)"]
        
        for i in 0..<value.count {
            let label = ApplyAuditTitle(String(i + 1), title: value[i])
            applyAuditValues.append(label)
            scrollView.addSubview(label)
            
            if i == 0 {
                applyAuditValues[i].snp.makeConstraints {
                    $0.top.equalTo(applyAuditTitle.snp.bottom).offset(24)
                    $0.leading.equalToSuperview().offset(20)
                    $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
                }
            } else {
                applyAuditValues[i].snp.makeConstraints {
                    $0.top.equalTo(applyAuditValues[i-1].snp.bottom).offset(14)
                    $0.leading.equalToSuperview().offset(20)
                    $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
                }
            }
            
        }
        
    }
    
    func getApplyDocLabel() {
        let value = ["취업지원신청서", "개인정보수집 · 이용 및 제공 동의서"]
        
        for i in 0..<value.count {
            let label = ApplyDocTitle(value[i])
            applyDocValues.append(label)
            scrollView.addSubview(label)
            
            if i == 0 {
                label.snp.makeConstraints {
                    $0.top.equalTo(applyDocTitle.snp.bottom).offset(19)
                    $0.leading.equalToSuperview().offset(22)
                    $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
                }
            } else {
                label.snp.makeConstraints {
                    $0.top.equalTo(applyDocValues[i-1].snp.bottom).offset(12)
                    $0.leading.equalToSuperview().offset(22)
                    $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
                }
            }
        }
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        //contentsBt conditionBt methodBt etcBt
    }
    
    func bindOutput() {
        
    }
}


class ScrollButton: UIButton {
    
    let label = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.textColor = UIColor.rgb(red: 143, green: 143, blue: 143)
    }
    
    let border = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 226, green: 226, blue: 226)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    func selected(_ isSelect: Bool) {
        if isSelect {
            label.textColor = UIColor.rgb(red: 255, green: 124, blue: 66)
            border.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
            
            border.snp.remakeConstraints {
                $0.height.equalTo(3)
                $0.bottom.leading.trailing.equalToSuperview()
            }
        } else {
            label.textColor = UIColor.rgb(red: 143, green: 143, blue: 143)
            border.backgroundColor = UIColor.rgb(red: 226, green: 226, blue: 226)
            
            border.snp.remakeConstraints {
                $0.height.equalTo(2)
                $0.bottom.leading.trailing.equalToSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ text: String, isInit:Bool = false) {
        self.init()
        label.text = text
        
        if isInit {
            label.textColor = UIColor.rgb(red: 255, green: 124, blue: 66)
            border.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
            
            border.snp.remakeConstraints {
                $0.height.equalTo(3)
                $0.bottom.leading.trailing.equalToSuperview()
            }
        }
    }
    
}

class DetailTitleLabel: UIView {
    
    let label = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        $0.textColor = UIColor.rgb(red: 74, green: 74, blue: 74)
    }
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 255, green: 247, blue: 235)
        layer.cornerRadius = 16
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(9)
            $0.centerY.equalToSuperview()
        }
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(9)
            $0.centerY.equalToSuperview()
        }
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ text: String, image: UIImage) {
        self.init()
        label.text = text
        imageView.image = image
        
    }
    
}

class SubTitleLabel: UIView {
    
    let circleView = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 142, blue: 59)
        $0.layer.cornerRadius = 3
    }
    
    let label = UILabel().then {
        $0.textColor = UIColor.rgb(red: 94, green: 94, blue: 94)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
    }
    
    let button = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "docDetail_close")!, for: .normal)
    }
    
    let border = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circleView)
        circleView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(13)
            $0.width.height.equalTo(6)
        }
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(circleView.snp.trailing).offset(9)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.equalToSuperview().offset(-42)
        }
        
        addSubview(button)
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(13)
        }
        
        addSubview(border)
        border.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ text: String) {
        self.init()
        label.text = text
        
    }
    
    
}

class UnderLineLabel: UIView {
    
    let title = UILabel().then{
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let underline = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 228, blue: 182)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(underline)
        underline.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(title.snp.top).offset(13)
            $0.height.equalTo(7)
        }
        
        bringSubviewToFront(title)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ text: String) {
        self.init()
        title.text = text
        
    }
    
}


class PeopleDetailView: UIView {
    
    let ageTitle = UILabel().then {
        $0.text = "나이"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let ageValue = UILabel().then {
        $0.text = "제한없음"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    let residentTitle = UILabel().then {
        $0.text = "거주지"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let residentValue = UILabel().then {
        $0.text = "제한없음"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    let moneyTitle = UILabel().then {
        $0.text = "소득"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let moneyValue = UILabel().then {
        $0.text = "제한없음"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    let schollTitle = UILabel().then {
        $0.text = "학력"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let schollValue = UILabel().then {
        $0.text = "제한없음"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    let majorTitle = UILabel().then {
        $0.text = "전공"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let majorValue = UILabel().then {
        $0.text = "제한없음"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    let employTitle = UILabel().then {
        $0.text = "취업 상태"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let employValue = UILabel().then {
        $0.text = "제한없음"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    let specialTitle = UILabel().then {
        $0.text = "특화 분야"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
    }
    
    let specialValue = UILabel().then {
        $0.text = "제한없음"
        $0.textColor = UIColor.rgb(red: 128, green: 128, blue: 128)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ageTitle)
        ageTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(ageValue)
        ageValue.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(103)
            $0.trailing.equalToSuperview().offset(-61)
        }
        
        addSubview(residentTitle)
        residentTitle.snp.makeConstraints {
            $0.top.equalTo(ageTitle.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(residentValue)
        residentValue.snp.makeConstraints {
            $0.top.equalTo(ageValue.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(103)
            $0.trailing.equalToSuperview().offset(-61)
        }
        
        addSubview(moneyTitle)
        moneyTitle.snp.makeConstraints {
            $0.top.equalTo(residentTitle.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(moneyValue)
        moneyValue.snp.makeConstraints {
            $0.top.equalTo(residentValue.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(103)
            $0.trailing.equalToSuperview().offset(-61)
        }
        
        addSubview(schollTitle)
        schollTitle.snp.makeConstraints {
            $0.top.equalTo(moneyTitle.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(schollValue)
        schollValue.snp.makeConstraints {
            $0.top.equalTo(moneyValue.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(103)
            $0.trailing.equalToSuperview().offset(-61)
        }
        
        addSubview(majorTitle)
        majorTitle.snp.makeConstraints {
            $0.top.equalTo(schollTitle.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(majorValue)
        majorValue.snp.makeConstraints {
            $0.top.equalTo(schollValue.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(103)
            $0.trailing.equalToSuperview().offset(-61)
        }
        
        addSubview(employTitle)
        employTitle.snp.makeConstraints {
            $0.top.equalTo(majorTitle.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(employValue)
        employValue.snp.makeConstraints {
            $0.top.equalTo(majorValue.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(103)
            $0.trailing.equalToSuperview().offset(-61)
        }
        
        addSubview(specialTitle)
        specialTitle.snp.makeConstraints {
            $0.top.equalTo(employTitle.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(specialValue)
        specialValue.snp.makeConstraints {
            $0.top.equalTo(employValue.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(103)
            $0.trailing.equalToSuperview().offset(-61)
        }
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ApplyHowValueLabel: UIView {
    
    let imgView = UIImageView(image: UIImage(named: "docDetail_check")!)
    
    let title = UILabel().then {
        $0.textColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(7)
            $0.bottom.trailing.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ text: String) {
        self.init()
        title.text = text
    }
    
}

class ApplyAuditTitle: UIView {
    
    let numberLabel = UILabel().then {
        $0.textColor = UIColor.rgb(red: 210, green: 210, blue: 210)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
    }
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = UIColor.rgb(red: 99, green: 99, blue: 99)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(numberLabel.snp.trailing).offset(11)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ number: String, title: String) {
        self.init()
        numberLabel.text = number
        titleLabel.text = title
    }
}

class ApplyDocTitle:UIView {
    
    let imgView = UIImageView(image: UIImage(named: "docDetail_doc")!)
    
    let title = UILabel().then {
        $0.textColor = UIColor.rgb(red: 205, green: 153, blue: 117)
        $0.textAlignment = .left
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-3)
        }
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ title: String) {
        self.init()
        self.title.text = title
    }
    
}
