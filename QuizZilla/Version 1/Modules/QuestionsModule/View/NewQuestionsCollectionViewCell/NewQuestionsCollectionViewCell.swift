//
//  NewQuestionsCollectionViewCell.swift
//  QuizZilla
//
//  Created by APPLE on 15/05/23.
//

import UIKit

class NewQuestionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var hintImageView: UIImageView!
    @IBOutlet weak var supportImageView: UIImageView!
    
    
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option1Btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setupButtons(buttons:[UIButton]){
        for btn in buttons{
        }
    }

    
    
}
