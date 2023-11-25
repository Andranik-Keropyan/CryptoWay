//
//  ListOfExchanges.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import UIKit
import CoreLocation

class ListOfExchanges: UIViewController ,UITableViewDelegate {
  
    var arrayWithExchanges = [String] ()
    
    var dataExchanges: [ExchangesModel] = [.init(nameOfExchange: "BitcoinArmenia", address: "yerevan, komitas avenue", phoneOfExchange: "099123456", Longitude: 0.3242342, Latitude: 0.23423423),
            .init(nameOfExchange: "Bitcoin", address: "yerevan, center of city", phoneOfExchange: "12345678", Longitude: 0.0324234, Latitude: 0.234234)
        ]
    
    let tableOfExchanges: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(ExchangesTableViewCell.self, forCellReuseIdentifier: ExchangesTableViewCell.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayouts()
        makeConstraints()
        tableOfExchanges.delegate = self
        tableOfExchanges.dataSource = self
        view.backgroundColor = .brown
        // Do any additional setup after loading the view.
    }
    
    func makeLayouts() {
        self.view.addSubview(tableOfExchanges)
    }
    func makeConstraints() {
        tableOfExchanges.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListOfExchanges:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataExchanges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangesTableViewCell.id, for: indexPath)
        guard let exchangeCell = cell as? ExchangesTableViewCell else { return UITableViewCell() }
        exchangeCell.set(exchange_name: dataExchanges[indexPath.row] )
        return exchangeCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapNAV = self.tabBarController?.viewControllers?.last as? UINavigationController
        let mapVC = mapNAV?.viewControllers.last
        let convertedVC = mapVC as? MapController
        let coordinate = CLLocationCoordinate2D(latitude: dataExchanges[indexPath.row].Latitude , longitude:dataExchanges[indexPath.row].Longitude )
        convertedVC?.createMarker(coordinate: coordinate)
        mapVC?.tabBarController?.selectedIndex = 0
        
        
    }
}
