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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
        questionView.layer.cornerRadius = 20
        questionView.layer.masksToBounds = true
        
        hintImgView.applyBlurEffect()
        hintImgView.alpha = 0.65
        
        option1View.layer.cornerRadius = 20
        option1View.layer.masksToBounds = true
        
        option2View.layer.cornerRadius = 20
        option2View.layer.masksToBounds = true
        
        option3View.layer.cornerRadius = 20
        option3View.layer.masksToBounds = true
        
        option4View.layer.cornerRadius = 20
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
        option1View.animateView(correct: true)
    }
    
    @IBAction func option2Tapped(_ sender: UIButton) {
        option2View.animateView(correct: false)
    }
    
    
    @IBAction func option3Tapped(_ sender: UIButton) {
        option3View.animateView(correct: true)
    }
    
    @IBAction func option4Tapped(_ sender: UIButton) {
        option4View.animateView(correct: false)
    }
}
