//
//  ResultViewController.swift
//  QuizZilla
//
//  Created by APPLE on 11/05/23.
//

import UIKit
import Lottie

class ResultViewController: UIViewController {

    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var animationContView: UIView!
    @IBOutlet weak var congratsLbl: UILabel!
    @IBOutlet weak var scorePercentLbl: UILabel!
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    var animationView: LottieAnimationView?
    var animationString:String?
    var scorePercentStr = ""
    var scorePercentTextColor = ""
    var congratsStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        contView.layer.cornerRadius = 20
        doneBtn.layer.cornerRadius = 20
        scorePercentLbl.text = scorePercentStr
        scorePercentLbl.textColor = UIColor(hex: scorePercentTextColor)
        congratsLbl.text = congratsStr
        if let animation = animationString{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                self.setAnimationView(animationName: animation, speed: 1.5)
            }
        }
    }
    
    private func setAnimationView(animationName:String, speed:Float){
        animationView = .init(name:animationName)
        animationView?.frame = animationContView.bounds
        animationView?.animationSpeed = CGFloat(speed)
        animationContView.addSubview(animationView!)
        animationView?.loopMode = .loop
        animationView?.play()
    }
    
    func configure(percentage: String, congoString:String, colorHexCode: String, animationString: String){
        self.scorePercentStr = percentage
        self.scorePercentTextColor = colorHexCode
        self.animationString = animationString
        self.congratsStr = congoString
    }
    
    @IBAction func dontBtnClicked(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
