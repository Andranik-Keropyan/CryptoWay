//
//  CryptoNews.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import UIKit
import SnapKit

class CryptoNews: UIViewController, UITableViewDelegate {
   
    var news = [NewsModel] ()
    var updatedNews = [String] ()
    var news1 = [Datum] ()
    var  updateNewsInfo: [Datum] = []

    let tableOfNews: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.hexStringToUIColor(hex: "#343434")
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.id)
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableOfNews.delegate = self
        tableOfNews.dataSource = self
        makeLayouts()
        makeConstraints()
        NetworkManager().getNews { [weak self] news in
            self?.news1 = news.data
            self?.tableOfNews.reloadData()

        } errorClosure: { error in
            print(error)
        }
    }
    


    func makeLayouts() {
        self.view.addSubview(tableOfNews)
    }
    
    func makeConstraints() {
        tableOfNews.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
    }
}

extension CryptoNews: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news1.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.id, for: indexPath)
        guard let newsCell = cell as? NewsTableViewCell else { return UITableViewCell() }
        newsCell.set(news_name: news1[indexPath.row] )
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2, animations: {
        cell!.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)}, completion: { finished in
        UIView.animate(withDuration: 0.2) { cell!.transform = .identity}
    })
        tableOfNews.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-15, height: headerView.frame.height-15)
            label.text = "Crypto News"
            label.backgroundColor = UIColor.hexStringToUIColor(hex: "#343434")
            label.layer.cornerRadius = 10
            label.font = UIFont.boldSystemFont(ofSize: 25)
            label.textAlignment = .center
            label.textColor = .white
            headerView.addSubview(label)
            return headerView
        }

}
