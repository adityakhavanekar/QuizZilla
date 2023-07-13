//
//  Enums.swift
//  QuizZilla
//
//  Created by APPLE on 12/07/23.
//

import Foundation

enum ColorEnums:String{
    case correct = "#3CB572"
    case wrong = "#FF5252"
}

enum APIEndpoints: String {
    private var baseURL: String { return "http://207.154.204.149:3050" }

    case history = "/historyQuestions"
    case sports = "/sportQuestions"
    case science = "/scienceQuestions"
    case music = "/musicQuestions"
    case movie = "/movieQuestions"
    
    var url: URL {
        guard let url = URL(string: baseURL) else {
            preconditionFailure("The url used in \(APIEndpoints.self) is not valid")
        }
        return url.appendingPathComponent(self.rawValue)
    }
}

enum Categories:String{
    case history = "History"
    case sports = "Sports"
    case science = "Science"
    case music = "Music"
    case movie = "Movies"
}

enum HomeCells:String{
    case categoryCell = "CategoryCollectionViewCell"
}

enum QuestionCells:String{
    case QuestionsCollectionViewCell = "QuestionsCollectionViewCell"
    case QuestionsCollectionViewCellV2 = "QuestionsCollectionViewCellV2"
    case NewQuestionsCollectionViewCell = "NewQuestionsCollectionViewCell"
}
