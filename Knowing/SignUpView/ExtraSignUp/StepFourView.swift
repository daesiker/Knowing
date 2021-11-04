//
//  ExtraSignFourView.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//

import Foundation
import UIKit
class StepFourView: UIView {
    let cellId = "cellId"
    let subject:[String] = ["인문", "사회", "법", "경영", "교육", "공학", "자연", "예체능", "의약", "기타"]
    let majorLabel = UILabel().then {
        $0.text = "전공 계열"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let majorCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let detailLabel = UILabel().then {
        $0.text = "학과"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let detailTextField:UITextField = {
       let tf = UITextField()
        tf.placeholder = "ex)) 경영"
        tf.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tf.frame.size.height - 1, width: tf.frame.width, height: 1)
        border.backgroundColor = CGColor.init(red: 151 / 255, green: 151 / 255, blue: 151 / 255, alpha: 1.0)
        tf.layer.addSublayer(border)
        
        return tf
    }()
    
    let subLabel = UILabel().then {
        $0.text = "학과"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubview(majorLabel)
        majorLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(majorLabel.snp.bottom).offset(294)
        }
        
        addSubview(majorCollectionView)
        majorCollectionView.snp.makeConstraints {
            $0.top.equalTo(majorLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(detailLabel.snp.top)
        }
        
        addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-103)
            $0.top.equalTo(detailLabel.snp.bottom).offset(26)
        }
        
        addSubview(detailTextField)
        detailTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(detailLabel.snp.bottom).offset(26)
            $0.trailing.equalTo(subLabel.snp.leading).offset(-10)
        }
    }
    
    func setCollectionView() {
        majorCollectionView.dataSource = self
        majorCollectionView.delegate = self
        majorCollectionView.register(MajorCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
}

extension StepFourView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 26, left: 25, bottom: 50, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.width - 90) / 3
        return CGSize(width: width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return subject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MajorCell
        cell.button.setTitle(subject[indexPath.item], for: .normal)
        return cell
    }
}


class MajorCell: UICollectionViewCell {
    
    let button = UIButton(type: .custom).then {
        $0.setTitle("", for: .normal)
        $0.layer.cornerRadius = 23.5
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.setTitleColor(UIColor.rgb(red: 108, green: 108, blue: 108), for: .normal)
        $0.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
        $0.contentEdgeInsets.top = 14
        $0.contentEdgeInsets.bottom = 14
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
