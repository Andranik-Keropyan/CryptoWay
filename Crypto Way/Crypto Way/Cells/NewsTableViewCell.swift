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
    
    lazy var stackView: UIStackView = {
        let myStack = UIStackView()
        myStack.spacing = 10
        myStack.layer.cornerRadius = 10
        myStack.axis = .vertical
        myStack.backgroundColor = UIColor.hexStringToUIColor(hex: "#B5838D")
        return myStack
    } ()
    
    lazy var nameOfTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 20)
        title.layer.cornerRadius = 8
        return title
    }()
    
    lazy var nameOfDescription: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        return description
    }()
    
    lazy var imageOfNews: UIImageView = {
        let image = UIImageView ()
        return image
    } ()

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
        makeLayouts()
        makeConstraints()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        }
    }
    func makeLayouts() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameOfTitle)
        stackView.addArrangedSubview(nameOfDescription)
        stackView.addArrangedSubview(imageOfNews)
    }
    
    func setImageFrom(_ url: URL) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.imageOfNews.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageOfNews.image = UIImage(systemName: "gear")
    }
    
    func set(news_name: Datum) {
        nameOfTitle.text = news_name.title
        nameOfDescription.text = news_name.body
        setImageFrom(news_name.imageurl)
    }
}
