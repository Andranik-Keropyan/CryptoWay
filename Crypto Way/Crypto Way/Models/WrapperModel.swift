//
//  NewsModel.swift
//  Crypto Way
//
//  Created by mac on 21.11.23.
//

import Foundation

struct Wrapper<T: Decodable>: Decodable {

    let Data: [T]
    
    }

