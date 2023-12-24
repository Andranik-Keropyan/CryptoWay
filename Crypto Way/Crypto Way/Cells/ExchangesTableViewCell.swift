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
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#212246")
           view.layer.cornerRadius = 10
            view.layer.borderWidth = 1.0
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    lazy var nameOfExchange: UILabel = {
        let Exchange = UILabel()
        Exchange.backgroundColor = .clear
        Exchange.text = "name of Exchange"
        Exchange.font = UIFont(name: "Poppins", size: 16)
        Exchange.font = UIFont.boldSystemFont(ofSize: 16)
        Exchange.textColor = .white
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
        address.textColor = UIColor.hexStringToUIColor(hex: "#838C9E")
        address.font = UIFont.systemFont(ofSize: 12)
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
        phone.font = UIFont(name: "Poppins", size: 16)
        phone.font = UIFont.boldSystemFont(ofSize: 16)
        phone.textColor = .white
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
//        apply3DEffect()
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
            make.bottom.equalToSuperview().offset(-10)
        }
        nameOfExchange.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(30)
        }
        phoneOfExchange.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(50)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-30)
        }
        addressOfExchange.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(30)
            make.top.equalTo(nameOfExchange.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    func set(exchange_name: ExchangesModel) {
        nameOfExchange.text = exchange_name.nameOfExchange
        addressOfExchange.text = exchange_name.address
        phoneOfExchange.text = exchange_name.phoneOfExchange
    }
}
