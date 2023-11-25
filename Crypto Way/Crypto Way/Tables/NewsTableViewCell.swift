//
//  NewsTableViewCell.swift
//  Crypto Way
//
//  Created by mac on 21.11.23.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {

    static let id = String(describing: NewsTableViewCell.self)
    
    var newElements = [Datum] ()
    
    
    
    lazy var nameOfTitle: UILabel = {
        let title = UILabel()
        title.backgroundColor = .systemMint
        title.text = "name of title"
        title.isUserInteractionEnabled = true
        title.layer.masksToBounds = true
        title.layer.cornerRadius = 8
        contentView.addSubview(title)
        return title
    }()
    
    lazy var nameOfDescription: UILabel = {
        let description = UILabel()
        description.backgroundColor = .systemMint
        description.text = "Description"
        description.isUserInteractionEnabled = true
        description.layer.masksToBounds = true
        description.layer.cornerRadius = 8
        contentView.addSubview(description)
        return description
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
        nameOfTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(20)

        }
        nameOfDescription.snp.makeConstraints { make in
            make.top.equalTo(nameOfTitle.snp.top).offset(100)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(20)
        }
    }
    func makeLayouts() {
        contentView.addSubview(nameOfTitle)
        contentView.addSubview(nameOfDescription)

    }
        func set(news_name: NewsModel) {
//            nameOfTitle.text = news_name
//            nameOfTitle.text = news_name.data.first?.body
//            
        }
}
