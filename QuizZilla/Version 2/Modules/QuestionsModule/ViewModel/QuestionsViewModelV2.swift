//
//  QuestionsViewModelV2.swift
//  QuizZilla
//
//  Created by APPLE on 11/07/23.
//

import Foundation

class QuestionsViewModelV2{
    
    private var url:URL
    private var questions:[TriviaElementV2]?
    
    init(url: URL) {
        self.url = url
    }
    
    func getQuestions(completion:@escaping ()->()){
        NetworkManager.shared.request(url: url,method: .get,params: nil,headers: nil) { data in
            switch data{
            case .success(let gotData):
                do{
                    let jsonData = try JSONDecoder().decode([TriviaElementV2].self, from: gotData)
                    self.questions = jsonData.shuffled()
                    completion()
                }catch{
                    print("error")
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func getQuestionsCount()->Int?{
        self.questions?.count
    }
    
    func getQuestion(index:Int)->TriviaElementV2?{
        if let object = self.questions?[index]{
            return object
        }else{
            return nil
        }
    }
    
}
