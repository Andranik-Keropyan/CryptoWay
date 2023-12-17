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
    
    let icons: [String]  = [
        "https://www.klipartz.com/en/sticker-png-mxhjp",
        "https://www.hiclipart.com/free-transparent-background-png-clipart-mcsvm",
        "https://www.pngwing.com/en/free-png-addfd",
        
    ]

    
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
        label.text = "No results found."
        label.textColor = .white
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#343434")
        tableOfCrypto.delegate = self
        tableOfCrypto.dataSource = self
        makeLayouts()
        makeConstraints()
        
        NetworkManager().getRate {[weak self]  rates in
            self?.allCurrentRate = rates.filter({$0.symbol.lowercased().contains("usdt")})
//            self?.allCurrentRate = rates.filter({$0.symbol.lowercased().dropLast(4)})
            let modifiedArray = self?.allCurrentRate.map { originalString in

    let endIndex = originalString.symbol.index(originalString.symbol.endIndex, offsetBy: -4)
                let truncatedString = originalString.symbol[..<endIndex]
                return  truncatedString
            }
            print(modifiedArray)
//            self?.shortedCurrencies = modifiedArray!

            self?.tableOfCrypto.reloadData()
        } errorClosure: { error in
            print(error)
        }

    }
    
    func makeLayouts() {
        self.view.addSubview(tableOfCrypto)
        self.view.addSubview(noResultsLabel)
    }
    
    func makeConstraints() {
        tableOfCrypto.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        noResultsLabel.snp.makeConstraints { make in
               make.center.equalToSuperview()
           }
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = UIColor.black
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 44)

        if let searchIcon = UIImage(systemName: "magnifyingglass") {
            searchController.searchBar.setImage(searchIcon, for: .search, state: .normal)
            let searchTextField = searchController.searchBar.searchTextField
            searchTextField.textColor = .white
            searchTextField.tintColor = .white
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
        noResultsLabel.isHidden = !filteredData.isEmpty
        return searchController.isActive ? filteredData.count : allCurrentRate.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCryptoViewCell.id, for: indexPath) as! ListCryptoViewCell
        let dataItem = searchController.isActive ? filteredData[indexPath.row] : allCurrentRate[indexPath.row]
        cell.set(rate_name: allCurrentRate[indexPath.row])
        return cell
    }
    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ListCryptoViewCell.id, for: indexPath)
//        guard let cryptoCell = cell as? ListCryptoViewCell else { return ListCryptoViewCell() }
//        cryptoCell.set(rate_name: allCurrentRate[indexPath.row] )
//        cryptoCell.iconImageView.setViewModel(.init())
//        cryptoCell.iconImageView.viewModel?.setImageFrom(icons[indexPath.row])
//        print(allCurrentRate)
//        return cryptoCell
//    }
    
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
