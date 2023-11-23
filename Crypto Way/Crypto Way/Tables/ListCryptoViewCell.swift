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
    
    lazy var nameOfFiat: UILabel = {
        let fiat = UILabel()
        fiat.backgroundColor = .systemMint
        fiat.text = ""
        fiat.isUserInteractionEnabled = true
        fiat.layer.masksToBounds = true
        fiat.layer.cornerRadius = 8
        contentView.addSubview(fiat)
        return fiat
    }()
    
    lazy var nameOfCrypto: UILabel = {
        let crypto = UILabel()
        crypto.backgroundColor = .systemMint
        crypto.text = "name of crypto"
        crypto.isUserInteractionEnabled = true
        crypto.layer.masksToBounds = true
        crypto.layer.cornerRadius = 8
        contentView.addSubview(crypto)
        return crypto
    }()
    
    lazy var rateOfCrypto: UILabel = {
        let rate = UILabel()
        rate.backgroundColor = .systemMint
        rate.text = "rate of crypto"
        rate.isUserInteractionEnabled = true
        rate.layer.masksToBounds = true
        rate.layer.cornerRadius = 8
        contentView.addSubview(rate)
        return rate
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        makeLayouts()
        self.backgroundColor = UIColor(red: 188/250, green: 161/250, blue: 143/250, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.yellow.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        nameOfCrypto.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(20)
        }
        nameOfFiat.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(nameOfCrypto.snp.trailing).offset(20)
            make.height.equalTo(20)
        }
        rateOfCrypto.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(20)
        }
        
        
    }
    func makeLayouts() {
        contentView.addSubview(nameOfFiat)
        contentView.addSubview(nameOfCrypto)
        contentView.addSubview(rateOfCrypto)
    }
    
    func set(rate_name: CryptoModel) {
        nameOfCrypto.text = rate_name.symbol
        rateOfCrypto.text = rate_name.price
    }
    
}
