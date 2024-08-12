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
    
    var activityIndicator : UIActivityIndicatorView?
    var viewModel:QuestionsViewModelV2?
    var categoryStr: String = ""
    var scorePoints:Int = 0
    
//    private let banner:GADBannerView = {
//        let banner = GADBannerView()
//        banner.adUnitID = Adverts.bannerAd
//        banner.load(GADRequest())
//        banner.backgroundColor = .clear
//        return banner
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        activityIndicator = showActivityIndicator(in: self.view)
        categoryLbl.text = categoryStr
        backButton.applyLiftedShadowEffectToButton(cornerRadius: backButton.frame.height/2)
        setupBannerAd()
        setupCollectionView()
        viewModel?.getQuestionsNew {
            DispatchQueue.main.async {
                self.questionCollectionView.reloadData()
                self.hideActivityIndicator(self.activityIndicator ?? UIActivityIndicatorView())
            }
        }
    }
    
    private func setupBannerAd(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
//            self.banner.rootViewController = self
//            self.banner.frame = self.adView.bounds
//            self.adView.addSubview(self.banner)
//        }
    }
    
    private func setupCollectionView(){
        questionCollectionView.register(UINib(nibName: CollectionViewCells.questionsCollectionViewCellV2, bundle: nil), forCellWithReuseIdentifier: CollectionViewCells.questionsCollectionViewCellV2)
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }

    private func hideActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
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
        let cell = questionCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.questionsCollectionViewCellV2, for: indexPath) as! QuestionsCollectionViewCellV2
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
                    let percentage = calculatePercentage(marksObtained: Double(scorePoints), totalMarks: Double(count))
                    if percentage >= 50{
                        vc.configure(percentage: "\(percentage)% Score", congoString: "Congrats", colorHexCode: Colors.correct, animationString: Animations.celebration)
                    }else if percentage < 50{
                        vc.configure(percentage: "\(percentage)% Score", congoString: "Try Again", colorHexCode: Colors.wrong, animationString: Animations.tryAgain)
                    }
                }
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func calculatePercentage(marksObtained: Double, totalMarks: Double) -> Int {
        let marks = Int((marksObtained / totalMarks) * 100.0)
        return marks
    }
}
