//
//  Enums.swift
//  QuizZilla
//
//  Created by APPLE on 12/07/23.
//

import Foundation
import UIKit

enum Environment{
    case production
    case test
}

let environment:Environment = .production

enum APIEndpoints: String {
    private var baseUrl:String {
        switch environment {
        case .production:
            return "http://207.154.204.149:3050"
        case .test:
            return "https://data.mongodb-api.com/app/application-1-ontwl/endpoint/quizilla"
        }
    }

    case history = "/historyQuestions"
    case sports = "/sportQuestions"
    case science = "/scienceQuestions"
    case music = "/musicQuestions"
    case movie = "/movieQuestions"
    
    var url: URL {
        guard let url = URL(string: baseUrl) else {
            preconditionFailure("The url used in \(APIEndpoints.self) is not valid")
        }
        return url.appendingPathComponent(self.rawValue)
    }
}

class APIKeys{
    static var mongoApiKey:String{
        switch environment {
        case .production:
            return "C4yuxxH0wfb5w4VXEWNC6UlQHJDzE39ZqmFHbD7ILyeX6KZPaUYpJEmQcxexOFO6"
        case .test:
            return "C4yuxxH0wfb5w4VXEWNC6UlQHJDzE39ZqmFHbD7ILyeX6KZPaUYpJEmQcxexOFO6"
        }
    }
}

class Adverts{
    static var bannerAd:String{
        switch environment {
        case .production:
            return "ca-app-pub-8260816350989246/9847500665"
        case .test:
            return "ca-app-pub-3940256099942544/2934735716"
        }
    }
}

class Categories{
    static let history = "History"
    static let sports = "Sports"
    static let science = "Science"
    static let music = "Music"
    static let movie = "Movies"
}

class CollectionViewCells{
    static var categoryCell = "CategoryCollectionViewCell"
    static var questionsCollectionViewCell = "QuestionsCollectionViewCell"
    static var questionsCollectionViewCellV2 = "QuestionsCollectionViewCellV2"
    static var newQuestionsCollectionViewCell = "NewQuestionsCollectionViewCell"
}

class Images{
    static var history = "History"
    static var science = "Science"
    static var music = "Music"
    static var sports = "Sports"
    static var movie = "Movies"
    static var hMenu = "menu"
    static var hUser = "user"
    static var americe = "america"
    static var correct = "correct"
    static var wrong = "wrong"
    static var qPoint = "point"
    static var tipUsed = "tipUsed"
    static var tip = "tipWithAd"
}

class Animations{
    static var celebration = "Celebration"
    static var tryAgain = "tryAgain"
}

class Colors{
    static var correct = "#3CB572"
    static var wrong = "#FF5252"
}
