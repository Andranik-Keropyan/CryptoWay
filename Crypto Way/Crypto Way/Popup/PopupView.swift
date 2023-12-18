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
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .blue
        return button
    }()
    
    @objc private func close() {
        self.closeAction?()
    }

    
    var closeAction: (()-> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
   
    private func setupUI() {
        backgroundColor = UIColor.hexStringToUIColor(hex: "#193a34")
        layer.cornerRadius = 10
        layer.masksToBounds = true
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(imageOfNews)
        addSubview(closeButton)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(imageOfNews.snp.top).offset(-20)
        }
        imageOfNews.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.bottom.equalTo(closeButton.snp.top).offset(-20)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(imageOfNews.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(0)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
