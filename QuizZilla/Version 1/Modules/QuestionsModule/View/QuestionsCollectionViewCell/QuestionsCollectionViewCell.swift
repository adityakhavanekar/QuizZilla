//
//  QuestionsCollectionViewCell.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import UIKit
import Lottie

protocol MyCollectionViewCellDelegate: AnyObject {
    func didTapButtonInCell(_ cell: QuestionsCollectionViewCell,points:Int)
}

class QuestionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hintImgView: UIImageView!
    @IBOutlet weak var animationContView: UIView!
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var questionNumberLbl: UILabel!
    
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    
    var delegate:MyCollectionViewCellDelegate?
    var correctAns:String?
    var animationView:LottieAnimationView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        setupUI()
    }
    
    private func setupUI(){
        self.isUserInteractionEnabled = false
        animationContView.isHidden = true
        setupButtons(buttons: [option1Btn,option2Btn,option3Btn,option4Btn])
        
        hintImgView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        hintImgView.addGestureRecognizer(tapGesture)
        hintImgView.image = UIImage(named: "tip")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6){
            self.isUserInteractionEnabled = true
        }
    }
    
    private func setupButtons(buttons:[UIButton]){
        for btn in buttons{
            btn.isEnabled = true
            btn.setTitleColor(.black, for: .normal)
            btn.setTitleColor(UIColor(hex: "#E4B7C5"), for: .disabled)
            btn.backgroundColor = .clear
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.cornerRadius = 25
            addShadow(to: btn)
        }
    }
    
    private func addShadow(to button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 5
    }
    
    private func answerClicked(sender:UIButton,corect:Bool){
        switch corect{
        case true:
            setAnimationView(animationName: "TickMark", speed: 2.5)
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.delegate?.didTapButtonInCell(self, points: 1)
            }
        case false:
            setAnimationView(animationName: "xMark", speed: 1.5)
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.delegate?.didTapButtonInCell(self, points: 0)
            }
        }
        self.isUserInteractionEnabled = false
        
    }
    
    private func makeBtnsDisable(buttons:[UIButton]){
        var count = 0
        for btn in buttons{
            if count == 2{
                break
            }else{
                if btn.currentTitle != correctAns{
                    seaSawButton(btn)
                    count += 1
                }else{
                    continue
                }
            }
        }
    }
    
    @objc func imageViewTapped() {
        print("Hint Tapped")
        makeBtnsDisable(buttons: [option1Btn,option2Btn,option3Btn,option4Btn])
        hintImgView.image = UIImage(named: "tipUsed")
        hintImgView.isUserInteractionEnabled = false
    }
    
    @IBAction func btn1Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            answerClicked(sender: sender, corect: true)
        }else{
            answerClicked(sender: sender, corect: false)
        }
    }
    
    @IBAction func optionBtn2Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            answerClicked(sender: sender, corect: true)
        }else{
            answerClicked(sender: sender, corect: false)
        }
    }
    
    @IBAction func optionBtn3Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            answerClicked(sender: sender, corect: true)
        }else{
            answerClicked(sender: sender, corect: false)
        }
    }
    
    @IBAction func optionBtn4Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            answerClicked(sender: sender, corect: true)
        }else{
            answerClicked(sender: sender, corect: false)
        }
    }
    
}

//MARK: - Animation Functions
extension QuestionsCollectionViewCell{
    
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
    
    private func setAnimationView(animationName:String, speed:Float){
        animationView?.removeFromSuperview()
        animationContView.isHidden = false
        animationView = .init(name:animationName)
        animationView?.frame = animationContView.bounds
        animationView?.animationSpeed = CGFloat(speed)
        animationContView.addSubview(animationView!)
        animationView?.play()
    }
    
    func seaSawButton(_ button: UIButton) {
        let duration = 0.2
        let angle: CGFloat = .pi / 8
        
        button.isEnabled = false
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
