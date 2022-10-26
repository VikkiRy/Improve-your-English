//
//  URLRequestDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 26/10/2022.
//

import Foundation

struct DataJSON: Decodable {
    var topics: [TopicJSON]?
}

struct TopicJSON: Decodable {
    var name: String?
    var words: [WordJSON]?
}

struct WordJSON: Decodable {
    var en: String?
    var rus: String?
}
