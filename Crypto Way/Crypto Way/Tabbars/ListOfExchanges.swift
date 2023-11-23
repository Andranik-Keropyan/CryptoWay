//
//  ListOfExchanges.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import UIKit

class ListOfExchanges: UIViewController
//,
//                        UITableViewDelegate
{
  
    var arrayWithExchanges = [String] ()
    
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
//        tableOfExchanges.delegate = self
//        tableOfExchanges.dataSource = self
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

//extension ListOfExchanges:UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        arrayWithExchanges.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
