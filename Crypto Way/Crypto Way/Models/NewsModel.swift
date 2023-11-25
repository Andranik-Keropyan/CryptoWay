//
//  NewsModel.swift
//  Crypto Way
//
//  Created by mac on 21.11.23.
//

import Foundation

struct NewsModel: Decodable {

    let data: [Datum]

    enum CodingKeys: String, CodingKey {

        case data = "Data"

    }
}

struct Datum: Decodable {

    let title: String?
    let body: String?


    enum CodingKeys: String, CodingKey {
        case title,body
    }
}



