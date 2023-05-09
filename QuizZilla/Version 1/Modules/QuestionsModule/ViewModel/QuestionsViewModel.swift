//
//  QuestionsViewModel.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import Foundation

class QuestionsViewModel{
    
    private var url:URL
    private var questions:[Trivia]?
    
    init(url: URL) {
        self.url = url
    }
    
    func getQuestions(completion:@escaping ()->()){
        NetworkManager.shared.request(url: url,method: .get,params: nil,headers: nil) { data in
            switch data{
            case .success(let gotData):
                do{
                    let jsonData = try JSONDecoder().decode([Trivia].self, from: gotData)
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
    
    func getQuestion(index:Int)->Trivia?{
        if let object = self.questions?[index]{
            return object
        }else{
            return nil
        }
    }
}
