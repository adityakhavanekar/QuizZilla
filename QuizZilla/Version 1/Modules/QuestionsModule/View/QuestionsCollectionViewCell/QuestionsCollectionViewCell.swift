//
//  QuestionsCollectionViewCell.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import UIKit

class QuestionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var questionNumberLbl: UILabel!
    
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    
    var correctAns:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        setupUI()
    }
    
    private func setupUI(){
        setupButtons(buttons: [option1Btn,option2Btn,option3Btn,option4Btn])
    }
    
    private func setupButtons(buttons:[UIButton]){
        for btn in buttons{
            btn.tintColor = .black
            btn.backgroundColor = .clear
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.cornerRadius = 25
            addShadow(to: btn)
        }
    }
    
    private func animateButton(_ button: UIButton,correct:Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            if correct == true{
                button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }else{
                button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    private func addShadow(to button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 5
    }
    
    
    
    @IBAction func btn1Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.tintColor  = .white
            animateButton(sender, correct: true)
        }else{
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.tintColor  = .white
            animateButton(sender, correct: false)
        }
    }
    
    @IBAction func optionBtn2Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.tintColor  = .white
            animateButton(sender, correct: true)
        }else{
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.tintColor  = .white
            animateButton(sender, correct: false)
        }
    }
    @IBAction func optionBtn3Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.tintColor  = .white
            animateButton(sender, correct: true)
        }else{
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.tintColor  = .white
            animateButton(sender, correct: false)
        }
    }
    
    @IBAction func optionBtn4Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.tintColor  = .white
            animateButton(sender, correct: true)
        }else{
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.tintColor  = .white
            animateButton(sender, correct: false)
        }
    }
    
    
}
