//
//  ExtraSignUpViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/02.
//

import UIKit
import Then
import RxCocoa
import RxSwift

class ExtraSignUpViewController: UIViewController {
    
    let vm = ExtraSignUpViewModel.instance
    let disposeBag = DisposeBag()
    var currentStep = SignUpStep.step1
    
    let footerView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.alwaysBounceVertical = false
        $0.isScrollEnabled = false
        $0.bounces = false
    }
    
    let childView:[UIView] = [StepOneView(), StepTwoView(), StepThreeView(), StepFourView(), StepFiveView()]
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let smallTitleLabel = UILabel().then {
        $0.text = "딱 맞는 복지정보, 노잉이 찾아드릴게요!"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textColor = UIColor.rgb(red: 127, green: 127, blue: 127)
        
    }
    
    let largeTitleLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "00님만의 혜택을 위해선\n추가 입력이 필요해요").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 24)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.numberOfLines = 2
    }
    
    let oneLabel = UILabel().then {
        $0.text = "1"
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
    }
    
    let twoLabel = UILabel().then {
        $0.text = "2"
        $0.isHidden = true
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
        
    }
    
    let threeLabel = UILabel().then {
        $0.text = "3"
        $0.isHidden = true
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
        
    }
    
    let fourLabel = UILabel().then {
        $0.text = "4"
        $0.isHidden = true
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
        
    }
    
    let fiveLabel = UILabel().then {
        $0.text = "5"
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 216, green: 216, blue: 216)
    }
    
    let progressView = UIProgressView().then {
        $0.tintColor = UIColor.rgb(red: 216, green: 216, blue: 216)
        $0.progressTintColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.progress = 0.2
        $0.layer.cornerRadius = 3.5
    }
    
    let subTitle1 = UILabel().then {
        $0.text = "카테고리 중 "
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    let subTitle2 = UIImageView(image: UIImage(named: "star")!).then {
        $0.contentMode = .scaleAspectFit
    }
    
    let subTitle3 = UILabel().then {
        $0.text = "은 필수 기재 사항이에요."
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    let nextBt = UIButton(type: .custom).then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 177, green: 177, blue: 177)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 147, bottom: 13, right: 147)
        $0.isEnabled = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        addContentScrollView()
    }
    
    private func addContentScrollView() {
        footerView.frame = UIScreen.main.bounds
        footerView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(childView.count), height: UIScreen.main.bounds.height * 0.63)
        for i in 0..<childView.count {
            let xPos = self.view.frame.width * CGFloat(i)
            childView[i].frame = CGRect(x: xPos, y: 0, width: footerView.bounds.width, height: UIScreen.main.bounds.height * 0.63)
            footerView.addSubview(childView[i])
            footerView.contentSize.width = childView[i].frame.width * CGFloat(i + 1)
        }
    }
    
    func animateView() {
        
        if smallTitleLabel.isHidden == true {
            smallTitleLabel.isHidden = false
            largeTitleLabel.isHidden = false
            largeTitleLabel.snp.makeConstraints {
                $0.top.equalTo(smallTitleLabel.snp.bottom).offset(10)
                $0.leading.equalToSuperview().offset(26)
            }
            smallTitleLabel.snp.makeConstraints {
                $0.top.equalTo(backBt.snp.bottom).offset(24)
                $0.leading.equalToSuperview().offset(26)
            }
            progressView.snp.makeConstraints {
                $0.top.equalTo(largeTitleLabel.snp.bottom).offset(51)
            }
        } else {
            smallTitleLabel.isHidden = true
            largeTitleLabel.isHidden = true
            progressView.snp.makeConstraints {
                
                $0.top.equalTo(backBt.snp.bottom).offset(32)
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    
}

extension ExtraSignUpViewController {
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(1)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(smallTitleLabel)
        smallTitleLabel.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(26)
        }
        
        safeArea.addSubview(largeTitleLabel)
        largeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(smallTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(26)
        }
        
        safeArea.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.top.equalTo(largeTitleLabel.snp.bottom).offset(51)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(8)
        }
        
        safeArea.addSubview(oneLabel)
        oneLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset((view.frame.width - 50) * 0.2 + 21)
        }
        
        safeArea.addSubview(twoLabel)
        twoLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset((view.frame.width - 50) * 0.4 + 21)
        }
        
        safeArea.addSubview(threeLabel)
        threeLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset((view.frame.width - 50) * 0.6 + 21)
        }
        
        safeArea.addSubview(fourLabel)
        fourLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset((view.frame.width - 50) * 0.8 + 21)
        }
        
        safeArea.addSubview(fiveLabel)
        fiveLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        let subTitle = UIStackView(arrangedSubviews: [subTitle1, subTitle2, subTitle3]).then {
            $0.axis = .horizontal
            $0.spacing = 1
            $0.distribution = .fillProportionally
        }
        
        safeArea.addSubview(subTitle)
        subTitle.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(78)
            $0.trailing.equalToSuperview().offset(-77)
        }
        
        safeArea.addSubview(footerView)
        footerView.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.bottom)
        }
        
        safeArea.addSubview(nextBt)
        nextBt.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-22)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-25)
        }
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        nextBt.rx.tap
            .bind(to: vm.rootView.input.nextBt)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        vm.stepOne.output.goCityView.subscribe(onNext: {
            let vc = AddressViewController()
            self.presentPanModal(vc)
        }).disposed(by: disposeBag)
        
        vm.stepOne.output.goGuView.drive(onNext: { value in
            if value != "시/도 선택" {
                let vc = AddressViewController()
                vc.allItem = address[value] ?? []
                vc.selectedItem = Observable<[String]>.of(address[value] ?? [])
                vc.isCity = false
                self.presentPanModal(vc)
            }
        }).disposed(by: disposeBag)
        
        
        vm.rootView.output.nextBtValid.drive(onNext: { value in
            if value {
                self.nextBt.isEnabled = true
                self.nextBt.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
            } else {
                self.nextBt.backgroundColor = UIColor.rgb(red: 177, green: 177, blue: 177)
                self.nextBt.isEnabled = false
            }
        }).disposed(by: disposeBag)
        
        
        vm.rootView.output.goSignUp
            .emit { _ in
                switch self.currentStep {
                case .step1:
                    self.goToStepTwo()
                case .step2:
                    self.goToStepThree()
                case .step3:
                    self.goToStepFour()
                case .step4:
                    self.goToStepFive()
                case .step5:
                    print("step5")
                }
            }.disposed(by: disposeBag)
        
        
    }
    
    func goToStepOne() {
        self.animateView()
        self.progressView.setProgress(0.2, animated: true)
        self.oneLabel.isHidden = false
        self.twoLabel.isHidden = true
        let contentOffset = CGPoint(x: 0, y: 0)
        self.footerView.setContentOffset(contentOffset, animated: true)
        self.currentStep = .step1
    }
    
    func goToStepTwo() {
        self.animateView()
        self.progressView.setProgress(0.4, animated: true)
        self.oneLabel.isHidden = true
        self.twoLabel.isHidden = false
        self.threeLabel.isHidden = true
        let contentOffset = CGPoint(x: self.view.frame.width, y: 0)
        self.footerView.setContentOffset(contentOffset, animated: true)
        currentStep = .step2
    }
    
    func goToStepThree() {
        self.progressView.setProgress(0.6, animated: true)
        self.twoLabel.isHidden = true
        self.threeLabel.isHidden = false
        self.fourLabel.isHidden = true
        let contentOffset = CGPoint(x: self.view.frame.width * 2, y: 0)
        self.footerView.setContentOffset(contentOffset, animated: true)
        currentStep = .step3
    }
    
    func goToStepFour() {
        self.progressView.setProgress(0.8, animated: true)
        self.threeLabel.isHidden = true
        self.fourLabel.isHidden = false
        let contentOffset = CGPoint(x: self.view.frame.width * 3, y: 0)
        self.footerView.setContentOffset(contentOffset, animated: true)
        currentStep = .step4
    }
    
    func goToStepFive() {
        self.progressView.setProgress(1.0, animated: true)
        self.fourLabel.isHidden = true
        let contentOffset = CGPoint(x: self.view.frame.width * 4, y: 0)
        self.footerView.setContentOffset(contentOffset, animated: true)
        currentStep = .step5
    }
    
    
    
    
    
    
}
