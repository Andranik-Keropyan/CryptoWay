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
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#B5838D")
        view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    lazy var nameOfFiat: UILabel = {
        let fiat = UILabel()
        fiat.backgroundColor = .clear
        fiat.text = ""
        fiat.isUserInteractionEnabled = true
        fiat.layer.masksToBounds = true
        fiat.layer.cornerRadius = 8
        contentView.addSubview(fiat)
        return fiat
    }()
    
    lazy var nameOfCrypto: UILabel = {
        let crypto = UILabel()
        crypto.backgroundColor = .clear
        crypto.text = "name of crypto"
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
        rate.isUserInteractionEnabled = true
        rate.layer.masksToBounds = true
        rate.layer.cornerRadius = 8
        contentView.addSubview(rate)
        return rate
    }()
    
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
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLayouts() {
        contentView.addSubview(cellView)
        cellView.addSubview(nameOfFiat)
        cellView.addSubview(nameOfCrypto)
        cellView.addSubview(rateOfCrypto)
    }
    
    func makeConstraints() {
        cellView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
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
  
    func set(rate_name: CryptoModel) {
        nameOfCrypto.text = rate_name.symbol
        rateOfCrypto.text = rate_name.price
    }
}
