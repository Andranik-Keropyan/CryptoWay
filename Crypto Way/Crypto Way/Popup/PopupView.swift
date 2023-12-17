//
//  PopupView.swift
//  Crypto Way
//
//  Created by mac on 17.12.23.
//

import UIKit
import SnapKit

class PopupView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    lazy var imageOfNews: UIImageView = {
        let image = UIImageView ()
        return image
    } ()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
//    func apply3DEffect() {
//        let rotationAngle = CGFloat(-15.0 * .pi / 180.0)
//        var transform = CATransform3DIdentity
//        transform.m34 = -1 / 800
//        transform = CATransform3DRotate(transform, rotationAngle, 1, 0, 0)
//        self.layer.transform = transform
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 0, height: 10)
//        self.layer.shadowRadius = 20
//    }

    private func setupUI() {
        backgroundColor = UIColor.hexStringToUIColor(hex: "#193a34")
        layer.cornerRadius = 10
        layer.masksToBounds = true
//        apply3DEffect()
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(imageOfNews)
        addSubview(closeButton)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualTo(imageOfNews.snp.top).offset(-20)
        }
        imageOfNews.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-10)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualTo(closeButton.snp.top).offset(-20)
        }

        closeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
