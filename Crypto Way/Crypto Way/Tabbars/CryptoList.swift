//
//  CryptoList.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import UIKit
import SnapKit

class CryptoList: UIViewController, UITableViewDelegate {

    var coins = [String]()
//    var rows = ListCryptoViewCell.id
    var allCurrentRate: [CryptoModel] = []
    

    let tableOfCrypto: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(ListCryptoViewCell.self, forCellReuseIdentifier: ListCryptoViewCell.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableOfCrypto.delegate = self
        tableOfCrypto.dataSource = self
        makeLayouts()
        makeConstraints()
        
        NetworkManager().getRate {[weak self]  rates in
            self?.allCurrentRate = rates
            self?.tableOfCrypto.reloadData()
        } errorClosure: { error in
            print(error)
        }

       
    }
    
    func makeLayouts() {
        self.view.addSubview(tableOfCrypto)
    }
    
    func makeConstraints() {
        tableOfCrypto.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
    }
    

}
extension CryptoList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCurrentRate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCryptoViewCell.id, for: indexPath)
        guard let cryptoCell = cell as? ListCryptoViewCell else { return UITableViewCell() }
        cryptoCell.set(rate_name: allCurrentRate[indexPath.row] )
        print(allCurrentRate)
        return cryptoCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    
}
