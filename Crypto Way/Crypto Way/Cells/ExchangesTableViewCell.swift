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
//           view.backgroundColor = UIColor.hexStringToUIColor(hex: "#050301")
           view.layer.cornerRadius = 10
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.green.cgColor
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    lazy var nameOfExchange: UILabel = {
        let Exchange = UILabel()
        Exchange.backgroundColor = .clear
        Exchange.text = "name of Exchange"
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
        address.textColor = .white
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
        apply3DEffect()
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
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).offset(30)
        }
        phoneOfExchange.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-30)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
        }
        addressOfExchange.snp.makeConstraints { make in
            make.top.equalTo(phoneOfExchange.snp.bottom).offset(20)
            make.centerX.equalTo(200)
//            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    func apply3DEffect() {
        let rotationAngle = CGFloat(-15.0 * .pi / 180.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 1000 
        transform = CATransform3DRotate(transform, rotationAngle, 1, 0, 0)
        cellView.layer.transform = transform
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cellView.layer.shadowRadius = 10
    }
    
    func set(exchange_name: ExchangesModel) {
        nameOfExchange.text = exchange_name.nameOfExchange
        addressOfExchange.text = exchange_name.address
        phoneOfExchange.text = exchange_name.phoneOfExchange
    }
}
