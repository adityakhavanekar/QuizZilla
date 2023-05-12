//
//  Sports Model.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import Foundation

struct Trivia: Codable {
    let id, question: String
    let options: [String]
    let ca: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case question, options
        case ca = "CA"
    }
}

struct TriviaElement: Codable {
    let id, question: String
    let options: [String]
    let ca: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case question, options
        case ca = "CA"
        case imageURL = "imageUrl"
    }
}
