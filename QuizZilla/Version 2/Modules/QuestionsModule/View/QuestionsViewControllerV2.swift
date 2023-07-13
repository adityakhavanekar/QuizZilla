//
//  QuestionsViewControllerV2.swift
//  QuizZilla
//
//  Created by APPLE on 11/07/23.
//

import UIKit
import GoogleMobileAds

class QuestionsViewControllerV2: UIViewController {

    @IBOutlet weak var bannerAdView: UIView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var questionCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var adView: UIView!
    
    var viewModel:QuestionsViewModelV2?
    var categoryStr: String = ""
    var scorePoints:Int = 0
    
    private let banner:GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = Adverts.bannerAdTest.rawValue
        banner.load(GADRequest())
        banner.backgroundColor = .clear
        return banner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        categoryLbl.text = categoryStr
        backButton.applyLiftedShadowEffect(cornerRadius: backButton.frame.height/2)
        setupBannerAd()
        setupCollectionView()
        viewModel?.getQuestions {
            DispatchQueue.main.async {
                self.questionCollectionView.reloadData()
            }
        }
    }
    
    private func setupBannerAd(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
            self.banner.rootViewController = self
            self.banner.frame = self.adView.bounds
            self.adView.addSubview(self.banner)
        }
    }
    
    private func setupCollectionView(){
        questionCollectionView.register(UINib(nibName: QuestionCells.QuestionsCollectionViewCellV2.rawValue, bundle: nil), forCellWithReuseIdentifier: QuestionCells.QuestionsCollectionViewCellV2.rawValue)
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension QuestionsViewControllerV2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getQuestionsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = questionCollectionView.dequeueReusableCell(withReuseIdentifier: QuestionCells.QuestionsCollectionViewCellV2.rawValue, for: indexPath) as! QuestionsCollectionViewCellV2
        if let data = viewModel?.getQuestion(index: indexPath.row){
            var model = data
            model.options.shuffle()
            cell.delegate = self
            cell.setupCell(model: model,questionNumber: indexPath.row+1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = questionCollectionView.frame.width
        let height = questionCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension QuestionsViewControllerV2: QuestionsCollectionViewCellDelegateV2{
    
    func optionTapped(cell: QuestionsCollectionViewCellV2, points: Int) {
        scorePoints += points
        guard let indexPath = questionCollectionView.indexPath(for: cell) else { return }
        if let count = viewModel?.getQuestionsCount(){
            if indexPath.row < count - 1 {
                let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                    self.questionCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                }
            }else{
                let vc = ResultViewControllerV2()
                if let count = viewModel?.getQuestionsCount(){
                    let percentage = calculatePercentage(marksObtained: Double(self.scorePoints), totalMarks: Double(count))
                    if percentage >= 50{
                        vc.configure(percentage: "\(percentage)% Score", congoString: "Congrats", colorHexCode: "#3CB572", animationString: "Celebration")
                    }else if percentage < 50{
                        vc.configure(percentage: "\(percentage)% Score", congoString: "Try Again", colorHexCode: "#FF5252", animationString: "tryAgain")
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        func calculatePercentage(marksObtained: Double, totalMarks: Double) -> Int {
            let marks = Int((marksObtained / totalMarks) * 100.0)
            return marks
        }
    }
    
}
