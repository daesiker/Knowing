//
//  PersonnalInfoViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/30.
//

import UIKit
import RxCocoa
import RxSwift

class PersonnalInfoViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    lazy var scrollView = UIScrollView(frame: .zero).then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.frame = UIScreen.main.bounds
        $0.backgroundColor = .white
    }
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "개인정보 처리방침"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 18)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let sourceLb1 = UILabel().then {
        $0.text = "개인정보처리방침"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    let sourceDetailLb1 = UILabel().then {
        $0.text = "< 노잉 >('https://blog.naver.com/godgod153'이하'KNOWING')은(는) 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다."
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb2 = UILabel().then {
        $0.text = "제1조(개인정보의 처리목적)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    let sourceDetailLb2 = UILabel().then {
        $0.text = "< 노잉 >(이)가 개인정보 보호법 제32조에 따라 등록․공개하는 개인정보파일의 처리목적은 다음과 같습니다.\n1. 개인정보 파일명 : 노잉 정보 수집\n개인정보의 처리목적 : 개인 맞춤형 서비스 제공 및 서비스 운영\n수집방법 : 생성정보 수집 툴을 통한 수집, 소셜로그인\n보유근거 : 개인 맞춤형 서비스 제공\n보유기간 : 1년\n관련법령 : 신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년"
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb3 = UILabel().then {
        $0.text = "제2조(정보주체와 법정대리인의 권리·의무 및 그 행사방법)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb3 = UILabel().then {
        $0.text = "① 정보주체는 노잉에 대해 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.\n② 제1항에 따른 권리 행사는노잉에 대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 노잉은(는) 이에 대해 지체 없이 조치하겠습니다.\n③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.\n④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.\n⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.\n⑥ 노잉은(는) 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다."
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb4 = UILabel().then {
        $0.text = "제3조(처리하는 개인정보의 항목 작성)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb4 = UILabel().then {
        $0.text = "① < 노잉 >은(는) 다음의 개인정보 항목을 처리하고 있습니다.\n1< 노잉 정보 수집 >\n필수항목 : 이메일, 휴대전화번호, 비밀번호, 성별, 생년월일, 이름, 서비스 이용 기록, 접속 로그, 접속 IP 정보\n선택항목 : 직업, 학력"
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb5 = UILabel().then {
        $0.text = "제4조(개인정보의 파기)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb5 = UILabel().then {
        $0.text = "① < 노잉 > 은(는) 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.\n② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.\n1. 법령 근거 :\n2. 보존하는 개인정보 항목 : 계좌정보, 거래날짜\n③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.\n1. 파기절차\n< 노잉 > 은(는) 파기 사유가 발생한 개인정보를 선정하고, < 노잉 > 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.\n2. 파기방법\n전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다."
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb6 = UILabel().then {
        $0.text = "제5조(개인정보의 안전성 확보 조치)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb6 = UILabel().then {
        $0.text = "< 노잉 >은(는) 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.\n1. 정기적인 자체 감사 실시\n개인정보 취급 관련 안정성 확보를 위해 정기적(분기 1회)으로 자체 감사를 실시하고 있습니다.\n2. 개인정보 취급 직원의 최소화 및 교육\n개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다."
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb7 = UILabel().then {
        $0.text = "제6조(개인정보 자동 수집 장치의 설치•운영 및 거부에 관한 사항)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb7 = UILabel().then {
        $0.text = "노잉 은(는) 정보주체의 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용하지 않습니다."
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb8 = UILabel().then {
        $0.text = "제7조 (개인정보 보호책임자)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb8 = UILabel().then {
        $0.text = "① 노잉 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.\n▶ 개인정보 보호책임자\n성명 :조효진\n직책 :매니저\n직급 :매니저\n연락처 :01040667997, tiwe1126@naver.com, _\n※ 개인정보 보호 담당부서로 연결됩니다.\n▶ 개인정보 보호 담당부서\n부서명 :\n담당자 :\n연락처 :, ,\n② 정보주체께서는 노잉 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 노잉 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다."
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb9 = UILabel().then {
        $0.text = "제8조(개인정보 열람청구)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb9 = UILabel().then {
        $0.text = "정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다.\n< 노잉 >은(는) 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.\n▶ 개인정보 열람청구 접수·처리 부서\n부서명 :\n담당자 :\n연락처 : , ,"
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb10 = UILabel().then {
        $0.text = "제9조(권익침해 구제방법)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb10 = UILabel().then {
        $0.text = "정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.\n1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)\n2. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)\n3. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)\n4. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)\n「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.\n※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다."
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    let sourceLb11 = UILabel().then {
        $0.text = "제10조(개인정보 처리방침 변경)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.numberOfLines = 0
    }
    
    let sourceDetailLb11 = UILabel().then {
        $0.text = "① 이 개인정보처리방침은 2021년 11월 17부터 적용됩니다."
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        backBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        }
        
        scrollView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.height.equalTo(2)
        }
        
        scrollView.addSubview(sourceLb1)
        sourceLb1.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(31)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb1)
        sourceDetailLb1.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb1.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb2)
        sourceLb2.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb1.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb2)
        sourceDetailLb2.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb2.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb3)
        sourceLb3.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb2.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
        
        scrollView.addSubview(sourceDetailLb3)
        sourceDetailLb3.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb3.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb4)
        sourceLb4.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb3.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb4)
        sourceDetailLb4.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb4.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb5)
        sourceLb5.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb4.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb5)
        sourceDetailLb5.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb5.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb6)
        sourceLb6.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb5.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb6)
        sourceDetailLb6.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb6.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb7)
        sourceLb7.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb6.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb7)
        sourceDetailLb7.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb7.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb8)
        sourceLb8.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb7.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb8)
        sourceDetailLb8.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb8.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb9)
        sourceLb9.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb8.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb9)
        sourceDetailLb9.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb9.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb10)
        sourceLb10.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb9.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb10)
        sourceDetailLb10.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb10.snp.bottom).offset(13)
        }
        
        scrollView.addSubview(sourceLb11)
        sourceLb11.snp.makeConstraints {
            $0.top.equalTo(sourceDetailLb10.snp.bottom).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(sourceDetailLb11)
        sourceDetailLb11.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
            $0.top.equalTo(sourceLb11.snp.bottom).offset(13)
        }
        
        scrollView.layoutIfNeeded()
        
        scrollView.updateContentSize()
        
    }

}
