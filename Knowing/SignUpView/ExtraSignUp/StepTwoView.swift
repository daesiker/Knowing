//
//  ExtraSignTwoView.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//

import Foundation
import UIKit
class StepTwoView: UIView {
    let titleLabel = UILabel().then {
        $0.text = "stepTwo"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
