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
    var allCurrentRate: [CryptoModel] = []
    
    let tableOfCrypto: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
            self?.allCurrentRate = rates.filter({$0.symbol.lowercased().contains("usdt")})
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
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-15, height: headerView.frame.height-15)
            label.text = "rates of crypto"
            label.backgroundColor = UIColor.hexStringToUIColor(hex: "#6D6875")
            label.layer.cornerRadius = 10
            label.font = .systemFont(ofSize: 20)
            label.textAlignment = .center
            label.textColor = .black
            headerView.addSubview(label)
            return headerView
        }
}
