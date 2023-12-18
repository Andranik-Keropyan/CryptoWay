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
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#343434")
        tableOfCrypto.delegate = self
        tableOfCrypto.dataSource = self
        makeLayouts()
        makeConstraints()
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

    }
    
    func makeConstraints() {
        tableOfCrypto.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        noResultsLabel.snp.makeConstraints { make in
               make.center.equalToSuperview()
           }
        scrollToTopButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
            make.width.height.equalTo(50)
            
             }
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .green // Set your desired color here
        searchController.searchBar.barTintColor = UIColor.green
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
               .foregroundColor: UIColor.green // Set your desired color here
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
        return searchController.isActive ? filteredData.count : allCurrentRate.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCryptoViewCell.id, for: indexPath) as! ListCryptoViewCell
        let dataItem = searchController.isActive ? filteredData[indexPath.row] : allCurrentRate[indexPath.row]
        cell.set(rate_name: dataItem)
         self.onScrollToTopTap = {
               tableView.setContentOffset(.zero, animated: true)
           }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2, animations: {
        cell!.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)}, completion: { finished in
        UIView.animate(withDuration: 0.2) { cell!.transform = .identity}
    })
        tableOfCrypto.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: headerView.frame.width - 15, height: headerView.frame.height - 15))
        label.text = "Crypto Rates"
        label.backgroundColor = UIColor.hexStringToUIColor(hex: "#343434")
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = .white
        headerView.addSubview(label)
        return headerView
    }}
