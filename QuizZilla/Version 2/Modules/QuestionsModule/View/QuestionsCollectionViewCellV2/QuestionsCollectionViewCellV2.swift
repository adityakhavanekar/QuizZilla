//
//  QuestionsCollectionViewCellV2.swift
//  QuizZilla
//
//  Created by APPLE on 11/07/23.
//

import UIKit
import CoreImage

class QuestionsCollectionViewCellV2: UICollectionViewCell {
    
    @IBOutlet weak var hintImgView: UIImageView!
    
    @IBOutlet weak var questionView: UIView!
    
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option1Btn: UIButton!
    
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
    
    @IBOutlet weak var questionTitleLbl: UILabel!
    
    var correctAns : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
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
            self.option1AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option2AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option3AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option4AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
        }
    }
    
    
    @IBAction func option1Tapped(_ sender: UIButton) {
        if option1Btn.titleLabel?.text == correctAns{
            option1View.animateView(correct: true)
        }else{
            option1View.animateView(correct: false)
        }
        
    }
    
    @IBAction func option2Tapped(_ sender: UIButton) {
        if option2Btn.titleLabel?.text == correctAns{
            option2View.animateView(correct: true)
        }else{
            option2View.animateView(correct: false)
        }
    }
    
    
    @IBAction func option3Tapped(_ sender: UIButton) {
        if option3Btn.titleLabel?.text == correctAns{
            option3View.animateView(correct: true)
        }else{
            option3View.animateView(correct: false)
        }
    }
    
    @IBAction func option4Tapped(_ sender: UIButton) {
        if option4Btn.titleLabel?.text == correctAns{
            option4View.animateView(correct: true)
        }else{
            option4View.animateView(correct: false)
        }
    }
    
    func setupCell(model:TriviaElementV2){
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
