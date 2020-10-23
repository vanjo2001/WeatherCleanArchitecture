//
//  CustomTextView.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 20.10.20.
//

import UIKit

class CustomTextView: UITextView {
    
    static let hieghtAnchorIdentifier: String = "HeightInfoConstraint"
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func changeHeightConstraintIfExistsWithAnimation(_ identifier: String, howMuch: CGFloat = 0.6) {
        self.superview!.constraints.forEach { constraint in
            if constraint.identifier == identifier {
                
                constraint.isActive = false
                
                let newConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: superview,
                                                       attribute: .height,
                                                       multiplier: howMuch * (Double(constraint.multiplier).rounded(toPlaces: 3) == 0.333 ? 1.0 : 0.555),
                                                       constant: 0)
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .allowAnimatedContent) {
                    newConstraint.identifier = identifier
                    newConstraint.priority = UILayoutPriority.defaultHigh
                    newConstraint.isActive = true
                    self.superview!.layoutIfNeeded()
                } completion: { (comp) in
                }
                
            }
            
        }
    }
    
}
