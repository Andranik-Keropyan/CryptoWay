//
//  ExchangesTableViewCell.swift
//  Crypto Way
//
//  Created by mac on 21.11.23.
//

import UIKit

class ExchangesTableViewCell: UITableViewCell {
    
    static let id = String(describing: ExchangesTableViewCell.self)
    
    lazy var nameOfExchange: UILabel = {
        let Exchange = UILabel()
        Exchange.backgroundColor = .systemMint
        Exchange.text = "name of Exchange"
        Exchange.isUserInteractionEnabled = true
        Exchange.layer.masksToBounds = true
        Exchange.layer.cornerRadius = 8
        contentView.addSubview(Exchange)
        return Exchange
    }()
    
    lazy var addressOfExchange: UILabel = {
        let address = UILabel()
        address.backgroundColor = .systemMint
        address.text = "address"
        address.isUserInteractionEnabled = true
        address.layer.masksToBounds = true
        address.layer.cornerRadius = 8
        contentView.addSubview(address)
        return address
    }()
    
    lazy var phoneOfExchange: UILabel = {
        let phone = UILabel()
        phone.backgroundColor = .systemMint
        phone.text = "phone"
        phone.isUserInteractionEnabled = true
        phone.layer.masksToBounds = true
        phone.layer.cornerRadius = 8
        contentView.addSubview(phone)
        return phone
    }()
    
    
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        makeLayouts()
        makeConstraints()
        self.backgroundColor = UIColor(red: 150/250, green: 161/250, blue: 143/250, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.yellow.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
    }
    func makeLayouts() {
        contentView.addSubview(nameOfExchange)
        contentView.addSubview(addressOfExchange)
        contentView.addSubview(phoneOfExchange)

        
    }
    func makeConstraints() {
        nameOfExchange.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            
        }
        addressOfExchange.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)

        }
        phoneOfExchange.snp.makeConstraints { make in
            make.top.equalTo(addressOfExchange.snp.bottom).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)

        }
        
    }
    func set(exchange_name: ExchangesModel) {
        nameOfExchange.text = exchange_name.nameOfExchange
        addressOfExchange.text = exchange_name.address
        phoneOfExchange.text = exchange_name.phoneOfExchange
    }

}
