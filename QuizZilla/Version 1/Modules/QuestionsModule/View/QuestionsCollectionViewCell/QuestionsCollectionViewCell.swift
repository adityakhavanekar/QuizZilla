//
//  QuestionsCollectionViewCell.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import UIKit

protocol MyCollectionViewCellDelegate: AnyObject {
    func didTapButtonInCell(_ cell: QuestionsCollectionViewCell,points:Int)
}

class QuestionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var responseImgView: UIImageView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var questionNumberLbl: UILabel!
    
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    
    var delegate:MyCollectionViewCellDelegate?
    
    var correctAns:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        setupUI()
    }
    
    private func setupUI(){
        responseImgView.isHidden = true
        setupButtons(buttons: [option1Btn,option2Btn,option3Btn,option4Btn])
    }
    
    private func setupButtons(buttons:[UIButton]){
        for btn in buttons{
            btn.setTitleColor(.black, for: .normal)
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
    
    
    
    @IBAction func btn1Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            fadeInRotateAndFadeOutImageView(imageView: responseImgView)
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didTapButtonInCell(self, points: 1)
            }
        }else{
            fadeInShakeAndFadeOut(imageView: responseImgView)
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didTapButtonInCell(self, points: 0)
            }
        }
        
    }
    
    @IBAction func optionBtn2Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            fadeInRotateAndFadeOutImageView(imageView: responseImgView)
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didTapButtonInCell(self, points: 1)
            }
        }else{
            fadeInShakeAndFadeOut(imageView: responseImgView)
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didTapButtonInCell(self, points: 0)
            }
        }
    }
    
    @IBAction func optionBtn3Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            fadeInRotateAndFadeOutImageView(imageView: responseImgView)
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didTapButtonInCell(self, points: 1)
            }
        }else{
            fadeInShakeAndFadeOut(imageView: responseImgView)
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didTapButtonInCell(self, points: 0)
            }
        }
    }
    
    @IBAction func optionBtn4Clicked(_ sender: UIButton) {
        if sender.currentTitle == correctAns{
            fadeInRotateAndFadeOutImageView(imageView: responseImgView)
            sender.backgroundColor = UIColor(hex: "#4CAF50")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didTapButtonInCell(self, points: 1)
            }
        }else{
            fadeInShakeAndFadeOut(imageView: responseImgView)
            sender.backgroundColor = UIColor(hex: "#FF5252")
            sender.setTitleColor(.white, for: .normal)
            animateButton(sender, correct: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didTapButtonInCell(self, points: 0)
            }
        }
    }
    
}

//MARK: - Animation Functions
extension QuestionsCollectionViewCell{
    private func fadeInShakeAndFadeOut(imageView: UIImageView) {
        self.isUserInteractionEnabled = false
        
        imageView.image = UIImage(named: "wrong")
        imageView.isHidden = false
        imageView.alpha = 0.0
        
        UIView.animate(withDuration: 0.2) {
            imageView.alpha = 1.0
        } completion: { _ in
            let shakeAnimation = CABasicAnimation(keyPath: "position")
            shakeAnimation.duration = 0.02
            shakeAnimation.repeatCount = 10
            shakeAnimation.autoreverses = false
            shakeAnimation.fromValue = CGPoint(x: imageView.center.x - 10, y: imageView.center.y)
            shakeAnimation.toValue = CGPoint(x: imageView.center.x + 10, y: imageView.center.y)
            
            
            imageView.layer.add(shakeAnimation, forKey: "position")
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                UIView.animate(withDuration: 0.2) {
                    imageView.alpha = 0.0
                } completion: { _ in
                    imageView.isHidden = true
                    self.isUserInteractionEnabled = true
                }
            }
        }
        
    }
    
    func fadeInRotateAndFadeOutImageView(imageView:UIImageView) {
        self.isUserInteractionEnabled = false
        imageView.image = UIImage(named: "correct")
        imageView.alpha = 0.0
        imageView.isHidden = false
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            imageView.alpha = 1.0
            imageView.transform = CGAffineTransform(rotationAngle: 2*(.pi))
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                imageView.alpha = 0.0
            }) { _ in
                imageView.isHidden = true
                imageView.transform = .identity
                self.isUserInteractionEnabled = true
            }
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
}
