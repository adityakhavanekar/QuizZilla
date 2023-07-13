//
//  QuestionsCollectionViewCellV2.swift
//  QuizZilla
//
//  Created by APPLE on 11/07/23.
//

import UIKit
import CoreImage

protocol QuestionsCollectionViewCellDelegateV2{
    func optionTapped(cell:QuestionsCollectionViewCellV2,points:Int)
}

class QuestionsCollectionViewCellV2: UICollectionViewCell {
    
    @IBOutlet weak var hintImgView: UIImageView!
    
    @IBOutlet weak var questionView: UIView!
    
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option1Btn: UIButton!
    
    @IBOutlet weak var hintBtn: UIButton!
    
    @IBOutlet weak var option1View: UIView!
    @IBOutlet weak var option2View: UIView!
    @IBOutlet weak var option3View: UIView!
    @IBOutlet weak var option4View: UIView!
    
    @IBOutlet weak var option4AlphaView: UIView!
    @IBOutlet weak var option3AlphaView: UIView!
    @IBOutlet weak var option2AlphaView: UIView!
    @IBOutlet weak var option1AlphaView: UIView!
    
    @IBOutlet weak var option1TitleLbl: UILabel!
    @IBOutlet weak var option2TitleLbl: UILabel!
    @IBOutlet weak var option3TitleLbl: UILabel!
    @IBOutlet weak var option4TitleLbl: UILabel!
    
    @IBOutlet weak var option1AlphaTitleLbl: UILabel!
    @IBOutlet weak var option2AlphaTitleLbl: UILabel!
    @IBOutlet weak var option3AlphaTitleLbl: UILabel!
    @IBOutlet weak var option4AlphaTitleLbl: UILabel!
    
    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var questionTitleLbl: UILabel!
    
    var correctAns : String?
    var delegate : QuestionsCollectionViewCellDelegateV2?
    var hintUsed : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        setupUI()
    }
    
    private func setupUI(){
        isUserInteractionEnabled = true
        hintUsed = false
        
        questionView.layer.cornerRadius = 20
        questionView.layer.masksToBounds = true
        
        option1View.layer.cornerRadius = 20
        option2View.layer.cornerRadius = 20
        option3View.layer.cornerRadius = 20
        option4View.layer.cornerRadius = 20
        
        option1View.layer.masksToBounds = true
        option2View.layer.masksToBounds = true
        option3View.layer.masksToBounds = true
        option4View.layer.masksToBounds = true
        
        option1View.applyLiftedShadowEffectToView(cornerRadius: 20)
        option2View.applyLiftedShadowEffectToView(cornerRadius: 20)
        option3View.applyLiftedShadowEffectToView(cornerRadius: 20)
        option4View.applyLiftedShadowEffectToView(cornerRadius: 20)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            
            self.option1Btn.frame = self.option1View.bounds
            self.option2Btn.frame = self.option2View.bounds
            self.option3Btn.frame = self.option3View.bounds
            self.option4Btn.frame = self.option4View.bounds
            
            self.option1AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option2AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option3AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option4AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            
        }
        
        option1View.backgroundColor = .white
        option2View.backgroundColor = .white
        option3View.backgroundColor = .white
        option4View.backgroundColor = .white
        
        option1View.isUserInteractionEnabled = true
        option2View.isUserInteractionEnabled = true
        option3View.isUserInteractionEnabled = true
        option4View.isUserInteractionEnabled = true
        
        option1TitleLbl.textColor = .black
        option2TitleLbl.textColor = .black
        option3TitleLbl.textColor = .black
        option4TitleLbl.textColor = .black
        
        option1AlphaTitleLbl.textColor = .black
        option2AlphaTitleLbl.textColor = .black
        option3AlphaTitleLbl.textColor = .black
        option4AlphaTitleLbl.textColor = .black
    }
    
    private func makeBtnsDisable(labels:[UILabel]){
        var count = 0
        for lbl in labels{
            if count == 2{
                break
            }else{
                if lbl.text != correctAns{
                    lbl.superview?.isUserInteractionEnabled = false
                    lbl.superview?.seaSawView(hexString: ColorEnums.wrong.rawValue)
                    lbl.textColor = .white
                    count += 1
                }else{
                    continue
                }
            }
        }
    }
    
    
    @IBAction func hintBtnTapped(_ sender: UIButton) {
        if hintUsed == false{
            makeBtnsDisable(labels: [option1TitleLbl,option2TitleLbl,option3TitleLbl,option4TitleLbl])
            hintUsed = true
        }
    }
    
    @IBAction func option1Tapped(_ sender: UIButton) {
        if option1Btn.titleLabel?.text == correctAns{
            correctOrWrong(view: option1View, isCorrect: true)
        }else{
            correctOrWrong(view: option1View, isCorrect: false)
        }
        isUserInteractionEnabled = false
        option1TitleLbl.textColor = .white
    }
    
    @IBAction func option2Tapped(_ sender: UIButton) {
        if option2Btn.titleLabel?.text == correctAns{
            correctOrWrong(view: option2View, isCorrect: true)
        }else{
            correctOrWrong(view: option2View, isCorrect: false)
        }
        isUserInteractionEnabled = false
        option2TitleLbl.textColor = .white
    }
    
    
    @IBAction func option3Tapped(_ sender: UIButton) {
        if option3Btn.titleLabel?.text == correctAns{
            correctOrWrong(view: option3View, isCorrect: true)
        }else{
            correctOrWrong(view: option3View, isCorrect: false)
        }
        isUserInteractionEnabled = false
        option3TitleLbl.textColor = .white
    }
    
    @IBAction func option4Tapped(_ sender: UIButton) {
        if option4Btn.titleLabel?.text == correctAns{
            correctOrWrong(view: option4View, isCorrect: true)
        }else{
            correctOrWrong(view: option4View, isCorrect: false)
        }
        isUserInteractionEnabled = false
        option4TitleLbl.textColor = .white
    }
    
    private func correctOrWrong(view:UIView,isCorrect:Bool){
        switch isCorrect{
        case true:
            view.animateView(correct: true)
            view.backgroundColor = UIColor.init(hex: ColorEnums.correct.rawValue)
            delegate?.optionTapped(cell: self, points: 1)
        case false:
            view.animateView(correct: false)
            view.backgroundColor = UIColor.init(hex: ColorEnums.wrong.rawValue)
            delegate?.optionTapped(cell: self, points: 0)
        }
    }
    
    func setupCell(model:TriviaElementV2,questionNumber:Int){
        questionNumberLbl.text = "Question \(questionNumber)"
        questionTitleLbl.text = model.question
        
        option1TitleLbl.text = model.options[0]
        option2TitleLbl.text = model.options[1]
        option3TitleLbl.text = model.options[2]
        option4TitleLbl.text = model.options[3]
        
        option1Btn.setTitle(model.options[0], for: .normal)
        option2Btn.setTitle(model.options[1], for: .normal)
        option3Btn.setTitle(model.options[2], for: .normal)
        option4Btn.setTitle(model.options[3], for: .normal)
        
        correctAns = model.ca
        
        hintImgView.sd_setImage(with: URL(string: model.imageURL ?? "")) { image, err, cach, ur in
            self.hintImgView.applyBlurEffect()
            self.hintImgView.alpha = 0.5
        }
    }
}
