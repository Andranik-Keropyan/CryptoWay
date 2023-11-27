//
//  ExchangesTableViewCell.swift
//  Crypto Way
//
//  Created by mac on 21.11.23.
//

import UIKit

class ExchangesTableViewCell: UITableViewCell {
    
    static let id = String(describing: ExchangesTableViewCell.self)
    
    lazy var cellView: UIView = {
           let view = UIView()
           view.backgroundColor = UIColor.hexStringToUIColor(hex: "#B5838D")
           view.layer.cornerRadius = 10
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    lazy var nameOfExchange: UILabel = {
        let Exchange = UILabel()
        Exchange.backgroundColor = .clear
        Exchange.text = "name of Exchange"
        Exchange.isUserInteractionEnabled = true
        Exchange.layer.masksToBounds = true
        Exchange.layer.cornerRadius = 8
        contentView.addSubview(Exchange)
        return Exchange
    }()
    
    lazy var addressOfExchange: UILabel = {
        let address = UILabel()
        address.backgroundColor = .clear
        address.text = "address"
        address.isUserInteractionEnabled = true
        address.layer.masksToBounds = true
        address.layer.cornerRadius = 8
        contentView.addSubview(address)
        return address
    }()
    
    lazy var phoneOfExchange: UILabel = {
        let phone = UILabel()
        phone.backgroundColor = .clear
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
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
    }
    
    func makeLayouts() {
        addSubview(cellView)
        cellView.addSubview(nameOfExchange)
        cellView.addSubview(addressOfExchange)
        cellView.addSubview(phoneOfExchange)
    }
    
    func makeConstraints() {
        cellView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        nameOfExchange.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
        }
        phoneOfExchange.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
        }
        addressOfExchange.snp.makeConstraints { make in
            make.top.equalTo(phoneOfExchange.snp.bottom).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    func set(exchange_name: ExchangesModel) {
        nameOfExchange.text = exchange_name.nameOfExchange
        addressOfExchange.text = exchange_name.address
        phoneOfExchange.text = exchange_name.phoneOfExchange
    }
}
