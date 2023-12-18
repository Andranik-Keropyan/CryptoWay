//
//  NewsTableViewCell.swift
//  Crypto Way
//
//  Created by mac on 21.11.23.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {

    
    weak var presentingViewController: UIViewController?
    
    static let id = String(describing: NewsTableViewCell.self)
    
    var onScrollToTopTap: (() -> Void)?

    private let scrollToTopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scroll to Top", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(scrollToTopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let myStack = UIStackView()
        myStack.spacing = 30
        myStack.axis = .vertical
        myStack.layer.cornerRadius = 10
        myStack.layer.borderWidth = 1.0
        myStack.layer.borderColor = UIColor.green.cgColor
        return myStack
    } ()
    
    lazy var nameOfTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textColor = .white
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 20)
        title.layer.cornerRadius = 8
        return title
    }()
    
    lazy var nameOfDescription: UILabel = {
        let description = UILabel()
        description.textColor = .white
        description.numberOfLines = 0
        description.textAlignment = .justified
        return description
    }()
    
    lazy var imageOfNews: UIImageView = {
        let image = UIImageView ()
        return image
    } ()
    
    var spinner:  UIActivityIndicatorView = {
        let spinn = UIActivityIndicatorView ()
        spinn.color = .white
        spinn.isHidden = false
        return spinn
    }()

    var onCellTap: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    @objc private func cellTapped() {
        onCellTap?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeLayouts()
        makeConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        stackView.addGestureRecognizer(tapGesture)
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
        nameOfTitle.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(20)
            make.trailing.equalTo(stackView.snp.trailing).offset(-20)
            make.top.equalTo(stackView.snp.top).offset(20)
        }
        nameOfDescription.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(20)
            make.trailing.equalTo(stackView.snp.trailing).offset(-20)
        }
        imageOfNews.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(20)
            make.trailing.equalTo(stackView.snp.trailing).offset(-20)
            make.height.equalTo(200)
        }
        spinner.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(20)
            make.trailing.equalTo(stackView.snp.trailing).offset(-20)
            make.height.equalTo(200)

        }
        scrollToTopButton.snp.makeConstraints { make in
                   make.trailing.equalTo(contentView).offset(-16)
            make.leading.equalTo(contentView).offset(16)

                   make.bottom.equalTo(contentView).offset(-16)
               }
    }
    func makeLayouts() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameOfTitle)
        stackView.addArrangedSubview(nameOfDescription)
        stackView.addArrangedSubview(imageOfNews)
        stackView.addSubview(scrollToTopButton)
        imageOfNews.addSubview(spinner)

    }
    
    @objc private func scrollToTopButtonTapped() {
           onScrollToTopTap?() // отвечает за скролл ленты новостей 
       }
    
    func setImageFrom(_ url: URL) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.spinner.startAnimating()
                self.imageOfNews.image = image
                self.spinner.stopAnimating()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageOfNews.image = UIImage(systemName: "gear")
    }
    
    private func makeGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        self.addGestureRecognizer(tap)
    }
    
    
    private func showPopup() {
        let popupView = PopupView(frame: CGRect(x: -48, y: -300, width: 370, height: 630))
        popupView.titleLabel.text = nameOfTitle.text
        popupView.descriptionLabel.text = nameOfDescription.text
        popupView.imageOfNews.image = imageOfNews.image

        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.view.addSubview(popupView)

        // Set the presenting view controller
        presentingViewController = window?.rootViewController

        presentingViewController?.present(alert, animated: true, completion: nil)

        popupView.closeAction = {[ weak self] in
             self?.presentingViewController?.dismiss(animated: true)}
    }

    @objc private func close() {
        presentingViewController?.dismiss(animated: true)
    }
    

  
    
    func set(news_name: Datum) {
        nameOfTitle.text = news_name.title
        nameOfDescription.text = news_name.body
        setImageFrom(news_name.imageurl)
        
        onCellTap = { [weak self] in
                 self?.showPopup()
             }
    }
}
