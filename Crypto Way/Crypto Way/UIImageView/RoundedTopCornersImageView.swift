//
//  RoundedTopCornersImageView.swift
//  Crypto Way
//
//  Created by mac on 21.12.23.
//

import Foundation
import UIKit

class RoundedTopCornersImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()

        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 10.0, height: 10.0)
        ).cgPath

        layer.mask = maskLayer
    }
}
