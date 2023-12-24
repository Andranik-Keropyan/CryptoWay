//
//  ListCryptoViewCell.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import UIKit
import SnapKit

class ListCryptoViewCell: UITableViewCell {
    
    static let id = String(describing: ListCryptoViewCell.self)
        
    lazy var cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
         view.layer.borderWidth = 1.0
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#212246")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
       }()

    lazy var nameOfCrypto: UILabel = {
        let crypto = UILabel()
        crypto.backgroundColor = .clear
        crypto.text = "name of crypto"
        crypto.textColor = .white
        crypto.isUserInteractionEnabled = true
        crypto.layer.masksToBounds = true
        crypto.layer.cornerRadius = 8
        contentView.addSubview(crypto)
        return crypto
    }()
    
    lazy var rateOfCrypto: UILabel = {
        let rate = UILabel()
        rate.backgroundColor = .clear
        rate.text = "rate of crypto"
        rate.textColor = .white
        rate.isUserInteractionEnabled = true
        rate.layer.masksToBounds = true
        rate.layer.cornerRadius = 8
        contentView.addSubview(rate)
        return rate
    }()
    
    lazy var iconImageView: UIImageView = {
        var iconImage = UIImageView()
        iconImage = UIImageView(image:UIImage(named: "BTC") )
        return iconImage
    } ()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeLayouts()
        makeConstraints()
        apply3DEffect()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.layer.masksToBounds = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLayouts() {
        contentView.addSubview(cellView)
        cellView.addSubview(iconImageView)
        cellView.addSubview(nameOfCrypto)
        cellView.addSubview(rateOfCrypto)

    }
    
    func makeConstraints() {
        cellView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(5)
        }

        iconImageView.snp.makeConstraints { make in
            make.leading.top.equalTo(cellView).offset(20)
            make.trailing.equalTo(nameOfCrypto.snp.leading).offset(-20)
            make.height.width.equalTo(20)
        }

        nameOfCrypto.snp.makeConstraints { make in
            make.top.equalTo(cellView).offset(20)
            make.leading.equalTo(iconImageView.snp.trailing).offset(0)
            make.trailing.equalTo(rateOfCrypto.snp.leading).offset(20)
        }

        rateOfCrypto.snp.makeConstraints { make in
            make.trailing.equalTo(cellView).offset(-20)
            make.top.equalTo(cellView).offset(20)
            make.height.equalTo(20)
        }
    }
    
    func apply3DEffect() {
        let rotationAngle = CGFloat(-15.0 * .pi / 180.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 700
        transform = CATransform3DRotate(transform, rotationAngle, 1, 0, 0)
        cellView.layer.transform = transform
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cellView.layer.shadowRadius = 20
    }
  
    func set(rate_name: CryptoModel) {
        nameOfCrypto.text = String(rate_name.symbol.dropLast(4))
        rateOfCrypto.text = "\(Float(rate_name.price)!)"
    }
}
