//
//  TriviaModelV2.swift
//  QuizZilla
//
//  Created by APPLE on 11/07/23.
//

import Foundation

struct TriviaV2: Codable {
    let id, question: String
    let options: [String]
    let ca: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case question, options
        case ca = "CA"
    }
}

struct TriviaElementV2: Codable {
    let id, question: String
    var options: [String]
    let ca: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case question, options
        case ca = "CA"
        case imageURL = "imageUrl"
    }
}
