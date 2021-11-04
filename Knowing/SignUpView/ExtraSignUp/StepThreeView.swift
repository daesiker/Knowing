//
//  ExtraSignThreeView.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//
import Foundation
import UIKit

class StepThreeView: UIView{
    let titleLabel = UILabel().then {
        $0.text = "step Three"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
