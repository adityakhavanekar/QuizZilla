//
//  NewQuestionsCollectionViewCell.swift
//  QuizZilla
//
//  Created by APPLE on 15/05/23.
//

import UIKit
import Lottie

protocol MyCollectionViewCellDelegateNew: AnyObject {
    func didTapButtonInCell(_ cell: NewQuestionsCollectionViewCell,points:Int)
}

protocol ShowAd:MyCollectionViewCellDelegateNew{
    func showAd()
}

class NewQuestionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var animationContView: UIView!
    
    @IBOutlet weak var hintImageView: UIImageView!
    @IBOutlet weak var supportImageView: UIImageView!
    
    
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option1Btn: UIButton!
    
    var correctAns = ""
    var delegate:MyCollectionViewCellDelegateNew?
    var adDelegate:ShowAd?
    var animationView: LottieAnimationView?
    
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
        
        hintImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hintImageViewTapped))
        hintImageView.addGestureRecognizer(tapGesture)
        hintImageView.image = UIImage(named: "tip")
        supportImageView.layer.cornerRadius = 40
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6){
            self.isUserInteractionEnabled = true
        }
        option1Btn.isEnabled = true
        option2Btn.isEnabled = true
        option3Btn.isEnabled = true
        option4Btn.isEnabled = true
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
    
    @objc func hintImageViewTapped() {
        adDelegate?.showAd()
        print("Hint Tapped")
        makeBtnsDisable(buttons: [option1Btn,option2Btn,option3Btn,option4Btn])
        hintImageView.image = UIImage(named: "tipUsed")
        hintImageView.isUserInteractionEnabled = false
    }
    
    private func addShadow(to button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 5
    }
    
    private func setButton(button:UIButton,title:String){
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "TrebuchetMS-Bold", size: 15)!
        ]
        let attributedString = NSAttributedString(string: title, attributes: fontAttributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(hex: "#E4B7C5"), for: .disabled)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 25
        button.setTitle(title, for: .normal)
        addShadow(to: button)
    }
    
    private func answerClicked(sender:UIButton,corect:Bool){
        switch corect{
        case true:
            setAnimationView(animationName: "TickMark", speed: 2.5)
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            animateButton(sender, correct: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.delegate?.didTapButtonInCell(self, points: 1)
            }
        case false:
            setAnimationView(animationName: "xMark", speed: 1.5)
            sender.backgroundColor = UIColor(hex: "#FF5252")
            animateButton(sender, correct: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.delegate?.didTapButtonInCell(self, points: 0)
            }
        }
        sender.setTitleColor(.white, for: .normal)
        self.isUserInteractionEnabled = false
        
    }
    
    func setupCell(element:TriviaElement){
        self.questionLbl.text = element.question
        setButton(button: option1Btn, title: element.options[0])
        setButton(button: option2Btn, title: element.options[1])
        setButton(button: option3Btn, title: element.options[2])
        setButton(button: option4Btn, title: element.options[3])
        self.supportImageView.sd_setImage(with: URL(string: element.imageURL ?? ""))
        self.correctAns = element.ca
    }
    
    @IBAction func option1Clicked(_ sender: UIButton) {
        if sender.titleLabel?.text == correctAns{
            answerClicked(sender: sender, corect: true)
            print(correctAns)
        }else{
            answerClicked(sender: sender, corect: false)
            print(correctAns)
        }
    }
    
    @IBAction func option2Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            answerClicked(sender: sender, corect: true)
            print(correctAns)
        }else{
            answerClicked(sender: sender, corect: false)
            print(correctAns)
        }
        
    }
    
    @IBAction func option3Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            answerClicked(sender: sender, corect: true)
            print(correctAns)
        }else{
            answerClicked(sender: sender, corect: false)
            print(correctAns)
        }
        
    }
    
    @IBAction func option4Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            answerClicked(sender: sender, corect: true)
            print(correctAns)
        }else{
            answerClicked(sender: sender, corect: false)
            print(correctAns)
        }
        
    }
}

extension NewQuestionsCollectionViewCell{
    
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
