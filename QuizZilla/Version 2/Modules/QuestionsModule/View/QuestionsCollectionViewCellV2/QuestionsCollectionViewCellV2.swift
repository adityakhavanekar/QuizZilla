//
//  QuestionsCollectionViewCellV2.swift
//  QuizZilla
//
//  Created by APPLE on 11/07/23.
//

import UIKit

class QuestionsCollectionViewCellV2: UICollectionViewCell {
    
    @IBOutlet weak var hintImgView: UIImageView!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
        hintImgView.layer.cornerRadius = 20
        
        option1View.layer.cornerRadius = 20
        option1View.layer.borderColor = UIColor.lightGray.cgColor
        option1View.layer.borderWidth = 0
        option1View.layer.masksToBounds = true
        
        option2View.layer.cornerRadius = 20
        option2View.layer.borderColor = UIColor.lightGray.cgColor
        option2View.layer.borderWidth = 0
        option2View.layer.masksToBounds = true
        
        option3View.layer.cornerRadius = 20
        option3View.layer.borderColor = UIColor.lightGray.cgColor
        option3View.layer.borderWidth = 0
        option3View.layer.masksToBounds = true
        
        option4View.layer.cornerRadius = 20
        option4View.layer.borderColor = UIColor.lightGray.cgColor
        option4View.layer.borderWidth = 0
        option4View.layer.masksToBounds = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.option1AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option2AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option3AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
            self.option4AlphaView.addBorder(toSide: .right, withColor: UIColor.lightGray.cgColor, andThickness: 1)
        }
        
        option1View.applyLiftedShadowEffectToView(cornerRadius: 20)
        option2View.applyLiftedShadowEffectToView(cornerRadius: 20)
        option3View.applyLiftedShadowEffectToView(cornerRadius: 20)
        option4View.applyLiftedShadowEffectToView(cornerRadius: 20)
        
        option1Btn.setTitle("Ronaldo", for: .normal)
        option2Btn.setTitle("Messi", for: .normal)
        option3Btn.setTitle("Neymar", for: .normal)
        option4Btn.setTitle("Mbappe", for: .normal)
        
        option1Btn.tintColor = .clear
        option2Btn.tintColor = .clear
        option3Btn.tintColor = .clear
        option4Btn.tintColor = .clear
    }
    
    
    @IBAction func option1Tapped(_ sender: UIButton) {
        animateButton(option1View, correct: true)
    }
    
    @IBAction func option2Tapped(_ sender: UIButton) {
        animateButton(option2View, correct: true)
    }
    
    
    @IBAction func option3Tapped(_ sender: UIButton) {
        animateButton(option3View, correct: true)
    }
    
    @IBAction func option4Tapped(_ sender: UIButton) {
        animateButton(option4View, correct: true)
    }
}

//MARK: - Animations
extension QuestionsCollectionViewCellV2{
    private func animateButton(_ view: UIView,correct:Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            if correct == true{
                view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }else{
                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                view.transform = CGAffineTransform.identity
            }
        })
    }
    
    func seaSawButton(_ button: UIView) {
        let duration = 0.2
        let angle: CGFloat = .pi / 8
        
        button.backgroundColor = UIColor(hex: "#FF5252")
        
        let seaSawAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        seaSawAnimation.duration = duration
        seaSawAnimation.values = [0, angle, 0, -angle, 0]
        seaSawAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        seaSawAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut)
        ]
        button.layer.add(seaSawAnimation, forKey: "seaSawAnimation")
    }
}
