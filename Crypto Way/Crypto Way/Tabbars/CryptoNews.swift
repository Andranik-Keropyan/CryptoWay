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
    
    
    let tableOfNews: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableOfNews.delegate = self
        tableOfNews.dataSource = self
        makeLayouts()
        makeConstraints()
        
        view.backgroundColor = .brown
  
        NetworkManager().getNews { [weak self] news in
            self?.news = news.objects
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
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.id, for: indexPath)
        guard let newsCell = cell as? NewsTableViewCell else { return UITableViewCell() }
        newsCell.set(news_name: news[indexPath.row] )
        print(news)
        return newsCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
