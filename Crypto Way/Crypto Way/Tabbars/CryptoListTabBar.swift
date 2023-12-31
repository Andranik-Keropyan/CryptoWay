//
//  CryptoList.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import UIKit
import SnapKit

class CryptoList: UIViewController, UITableViewDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
            filteredData = allCurrentRate.filter { item in
                return item.symbol.lowercased().contains(searchText)
            }
            tableOfCrypto.reloadData()
        }
    }
    
    var searchController: UISearchController!
    var filteredData: [CryptoModel] = []
    var allCurrentRate: [CryptoModel] = []
    var shortedCurrencies: [CryptoModel] = []
    
    let tableOfCrypto: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCryptoViewCell.self, forCellReuseIdentifier: ListCryptoViewCell.id)
        return tableView
    }()
    
    private let titleOfPage: UILabel = {
        let title = UILabel()
        title.text = "Crypto Rates"
        title.font = UIFont.boldSystemFont(ofSize: 24)
        title.textColor = .white
        return title
    } ()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No results found"
        label.textColor = .white
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var onScrollToTopTap: (() -> Void)?

    private let scrollToTopButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        button.tintColor = UIColor.white
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(scrollToTopButtonTapped), for: .touchUpInside)
        return button
    }()
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#161730")
        tableOfCrypto.delegate = self
        tableOfCrypto.dataSource = self
        makeLayouts()
        makeConstraints()
        tableOfCrypto.allowsMultipleSelectionDuringEditing = true
        scrollToTopButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NetworkManager().getRate {[weak self]  rates in
            self?.allCurrentRate = rates.filter({$0.symbol.lowercased().contains("usdt")})
            self?.tableOfCrypto.reloadData()
        } errorClosure: { error in
            print(error)
        }

    }
    
    @objc private func scrollToTopButtonTapped() {
         onScrollToTopTap?()
     }
    
    func makeLayouts() {
        self.view.addSubview(tableOfCrypto)
        self.view.addSubview(noResultsLabel)
        self.view.addSubview(scrollToTopButton)
        self.view.addSubview(titleOfPage)
    }
    
    func makeConstraints() {
        tableOfCrypto.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.equalTo(titleOfPage.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)

        }
        noResultsLabel.snp.makeConstraints { make in
               make.center.equalToSuperview()
           }
        scrollToTopButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
            make.width.height.equalTo(50)
            }
        titleOfPage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(36)

        }
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .green
        searchController.searchBar.barTintColor = UIColor.gray
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
               .foregroundColor: UIColor.green
           ]
           searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes)

        if let searchIcon = UIImage(systemName: "magnifyingglass") {
            let tintedSearchIcon = searchIcon.withTintColor(.white, renderingMode: .alwaysOriginal)
                searchController.searchBar.setImage(tintedSearchIcon, for: .search, state: .normal)
            }

        
        if let searchText = searchController.searchBar.text?.lowercased() {
                filteredData = allCurrentRate.filter { item in
 
                    return item.symbol.lowercased().contains(searchText)
                }
                tableOfCrypto.reloadData()
            }
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
extension CryptoList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive, filteredData.isEmpty {
            noResultsLabel.isHidden = false
        } else {
            noResultsLabel.isHidden = true
        }
        
        if searchController.isActive {
            titleOfPage.isHidden = true
        } else {
            titleOfPage.isHidden = false
        }
        
        return searchController.isActive ? filteredData.count : allCurrentRate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCryptoViewCell.id, for: indexPath) as! ListCryptoViewCell
        let dataItem = searchController.isActive ? filteredData[indexPath.row] : allCurrentRate[indexPath.row]
        cell.set(rate_name: dataItem)
        self.onScrollToTopTap = {
            tableView.setContentOffset(.zero, animated: true)
            
        }
        if let image = UIImage(named: dataItem.symbol) {
            cell.iconImageView.image = image
        } else {
            print("cant find curren image ")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListCryptoViewCell

        UIView.animate(withDuration: 0.2, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)}, completion: { finished in
                UIView.animate(withDuration: 0.2) { cell.transform = .identity}

            })
        tableOfCrypto.deselectRow(at: indexPath, animated: true)
    }

}
