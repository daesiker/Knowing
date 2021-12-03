//
//  TmpChartViewController.swift
//  Knowing
//
//  Created by Jun on 2021/12/01.
//

import UIKit


class ChartView: UIView {
    let vm = MainTabViewModel.instance
    var category:[String] = []
    var unit:[Float] = []
    
    let chartTitle1 = UILabel().then {
        $0.text = "학생"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let chartProgress1 = VerticalProgressView().then {
        $0.backgroundColor = .clear
        $0.color = CGColor(red: 255/255, green: 228/255, blue: 182/255, alpha: 1.0)
        $0.progress = 1.0
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let chartImg1 = UIImageView(image: UIImage(named: "chartIndicator1"))
    
    let chartCountLb1 = UILabel().then {
        $0.text = "20"
        $0.textColor = UIColor.rgb(red: 185, green: 113, blue: 66)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
    
    let chartTitle2 = UILabel().then {
        $0.text = "취업"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let chartProgress2 = VerticalProgressView().then {
        $0.backgroundColor = .clear
        $0.color = CGColor(red: 255/255, green: 176/255, blue: 128/255, alpha: 1.0)
        $0.progress = 0.75
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let chartImg2 = UIImageView(image: UIImage(named: "chartIndicator2"))
    
    let chartCountLb2 = UILabel().then {
        $0.text = "15"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
    
    let chartTitle3 = UILabel().then {
        $0.text = "창업"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let chartProgress3 = VerticalProgressView().then {
        $0.backgroundColor = .clear
        $0.color = CGColor(red: 255/255, green: 176/255, blue: 97/255, alpha: 1.0)
        $0.progress = 0.5
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let chartImg3 = UIImageView(image: UIImage(named: "chartIndicator3"))
    
    let chartCountLb3 = UILabel().then {
        $0.text = "10"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
    
    let chartTitle4 = UILabel().then {
        $0.text = "주거\n금융"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let chartProgress4 = VerticalProgressView().then {
        $0.backgroundColor = .clear
        $0.color = CGColor(red: 255/255, green: 142/255, blue: 59/255, alpha: 1.0)
        $0.progress = 0.25
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let chartImg4 = UIImageView(image: UIImage(named: "chartIndicator4"))
    
    let chartCountLb4 = UILabel().then {
        $0.text = "5"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
    
    let chartTitle5 = UILabel().then {
        $0.text = "생활\n복지"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let chartProgress5 = VerticalProgressView().then {
        $0.backgroundColor = .clear
        $0.color = CGColor(red: 255/255, green: 136/255, blue: 84/255, alpha: 1.0)
        $0.progress = 0.01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let chartImg5 = UIImageView(image: UIImage(named: "chartIndicator5"))
    
    let chartCountLb5 = UILabel().then {
        $0.text = "0"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
    
    let chartTitle6 = UILabel().then {
        $0.text = "코로나\n19"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let chartProgress6 = VerticalProgressView().then {
        $0.backgroundColor = .clear
        $0.color = CGColor(red: 210/255, green: 132/255, blue: 81/255, alpha: 1.0)
        $0.progress = 0.01
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let chartImg6 = UIImageView(image: UIImage(named: "chartIndicator6"))
    
    let chartCountLb6 = UILabel().then {
        $0.text = "0"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sortCategory()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sortCategory() {
        var sortedCategory:[[Float]] = []
        for (k, v) in vm.posts {
            if k != "TotalCategory" {
                if k == "studentCategory" {
                    sortedCategory.append([0, Float(v.count)])
                } else if k == "employCategory" {
                    sortedCategory.append([1, Float(v.count)])
                } else if k == "foundationCategory" {
                    sortedCategory.append([2, Float(v.count)])
                } else if k == "residentCategory" {
                    sortedCategory.append([3, Float(v.count)])
                } else if k == "lifeCategory" {
                    sortedCategory.append([4, Float(v.count)])
                } else if k == "covidCategory" {
                    sortedCategory.append([5, Float(v.count)])
                }
            }
        }
        sortedCategory.sort { $0[1] > $1[1] }
        for sort in sortedCategory {
            if sort[0] == 0.0 {
                category.append("학생")
                unit.append(sort[1])
            } else if sort[0] == 1.0 {
                category.append("취업")
                unit.append(sort[1])
            } else if sort[0] == 2.0 {
                category.append("창업")
                unit.append(sort[1])
            } else if sort[0] == 3.0 {
                category.append("주거\n금융")
                unit.append(sort[1])
            } else if sort[0] == 4.0 {
                category.append("생활\n복지")
                unit.append(sort[1])
            } else if sort[0] == 5.0 {
                category.append("코로나\n19")
                unit.append(sort[1])
            }
        }
        
        chartTitle1.text = category[0]
        chartProgress1.progress = unit[0] >= 20 ? 1 : unit[0] == 0 ? 0.01 : unit[0] / 20
        chartCountLb1.text = String(Int(unit[0]))
        
        chartTitle2.text = category[1]
        chartProgress2.progress = unit[1] >= 20 ? 1 : unit[1] == 0 ? 0.01 : unit[1] / 20
        chartCountLb2.text = String(Int(unit[1]))
        
        chartTitle3.text = category[2]
        chartProgress3.progress = unit[2] >= 20 ? 1 : unit[2] == 0 ? 0.01 : unit[2] / 20
        chartCountLb3.text = String(Int(unit[2]))
        
        chartTitle4.text = category[3]
        chartProgress4.progress = unit[3] >= 20 ? 1 : unit[3] == 0 ? 0.01 : unit[3] / 20
        chartCountLb4.text = String(Int(unit[3]))
        
        chartTitle5.text = category[4]
        chartProgress5.progress = unit[4] >= 20 ? 1 : unit[4] == 0 ? 0.01 : unit[4] / 20
        chartCountLb5.text = String(Int(unit[4]))
        
        chartTitle6.text = category[5]
        chartProgress6.progress = unit[5] >= 20 ? 1 : unit[5] == 0 ? 0.01 : unit[5] / 20
        chartCountLb6.text = String(Int(unit[5]))
    }
    
    func setUI() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 30.0
        
        addSubview(chartTitle1)
        chartTitle1.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(23)
            $0.top.equalToSuperview().offset(202)
        }
        
        addSubview(chartProgress1)
        chartProgress1.snp.makeConstraints {
            $0.bottom.equalTo(chartTitle1.snp.top).offset(-7)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(22)
            $0.height.equalTo(146)
        }
        
        addSubview(chartImg1)
        chartImg1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13 + ((20 - unit[0]) * 7.2))
            $0.leading.equalToSuperview().offset(24)
        }
        
        chartImg1.addSubview(chartCountLb1)
        chartCountLb1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(chartTitle2)
        chartTitle2.snp.makeConstraints {
            $0.leading.equalTo(chartTitle1.snp.trailing).offset(30)
            $0.top.equalToSuperview().offset(202)
        }
        addSubview(chartProgress2)
        chartProgress2.snp.makeConstraints {
            $0.bottom.equalTo(chartTitle1.snp.top).offset(-7)
            $0.leading.equalTo(chartProgress1.snp.trailing).offset(30)
            $0.width.equalTo(22)
            $0.height.equalTo(146)
        }
        
        addSubview(chartImg2)
        chartImg2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13 + ((20 - unit[1]) * 7.2))
            $0.leading.equalTo(chartProgress1.snp.trailing).offset(30)
        }
        
        chartImg2.addSubview(chartCountLb2)
        chartCountLb2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(chartTitle3)
        chartTitle3.snp.makeConstraints {
            $0.leading.equalTo(chartTitle2.snp.trailing).offset(30)
            $0.top.equalToSuperview().offset(202)
        }
        addSubview(chartProgress3)
        chartProgress3.snp.makeConstraints {
            $0.bottom.equalTo(chartTitle1.snp.top).offset(-7)
            $0.leading.equalTo(chartProgress2.snp.trailing).offset(30)
            $0.width.equalTo(22)
            $0.height.equalTo(146)
        }
        addSubview(chartImg3)
        chartImg3.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13 + ((20 - unit[2]) * 7.2))
            $0.leading.equalTo(chartProgress2.snp.trailing).offset(30)
        }
        
        chartImg3.addSubview(chartCountLb3)
        chartCountLb3.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(chartTitle4)
        chartTitle4.snp.makeConstraints {
            $0.leading.equalTo(chartTitle3.snp.trailing).offset(30)
            $0.top.equalToSuperview().offset(202)
        }
        addSubview(chartProgress4)
        chartProgress4.snp.makeConstraints {
            $0.bottom.equalTo(chartTitle1.snp.top).offset(-7)
            $0.leading.equalTo(chartProgress3.snp.trailing).offset(30)
            $0.width.equalTo(22)
            $0.height.equalTo(146)
        }
        addSubview(chartImg4)
        chartImg4.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13 + ((20 - unit[3]) * 7.2))
            $0.leading.equalTo(chartProgress3.snp.trailing).offset(30)
        }
        
        chartImg4.addSubview(chartCountLb4)
        chartCountLb4.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(chartTitle5)
        chartTitle5.snp.makeConstraints {
            $0.leading.equalTo(chartTitle4.snp.trailing).offset(30)
            $0.top.equalToSuperview().offset(202)
        }
        addSubview(chartProgress5)
        chartProgress5.snp.makeConstraints {
            $0.bottom.equalTo(chartTitle1.snp.top).offset(-7)
            $0.leading.equalTo(chartProgress4.snp.trailing).offset(30)
            $0.width.equalTo(22)
            $0.height.equalTo(146)
        }
        addSubview(chartImg5)
        chartImg5.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13 + ((20 - unit[4]) * 7.2))
            $0.leading.equalTo(chartProgress4.snp.trailing).offset(30)
        }
        
        chartImg5.addSubview(chartCountLb5)
        chartCountLb5.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(chartTitle6)
        chartTitle6.snp.makeConstraints {
            $0.leading.equalTo(chartTitle5.snp.trailing).offset(30)
            $0.top.equalToSuperview().offset(202)
        }
        addSubview(chartProgress6)
        chartProgress6.snp.makeConstraints {
            $0.bottom.equalTo(chartTitle1.snp.top).offset(-7)
            $0.leading.equalTo(chartProgress5.snp.trailing).offset(30)
            $0.width.equalTo(22)
            $0.height.equalTo(146)
        }
        addSubview(chartImg6)
        chartImg6.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13 + ((20 - unit[5]) * 7.2))
            $0.leading.equalTo(chartProgress5.snp.trailing).offset(30)
        }
        
        chartImg6.addSubview(chartCountLb6)
        chartCountLb6.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
        
        
    }
    
}
