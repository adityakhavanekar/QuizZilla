//
//  QuestionsViewController.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import UIKit
import SDWebImage
import GoogleMobileAds

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var pointImgView: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var questionsCollectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    
    var viewModel : QuestionsViewModel?
    var categoryStr: String?
    
    var points:Int = 0 {
        didSet{
            animateImageView(imageView: pointImgView)
            pointLbl.text = "\(points)"
        }
    }
    
    private let banner:GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-8260816350989246/3781983591"
        banner.load(GADRequest())
        banner.backgroundColor = .red
        return banner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        banner.rootViewController = self
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
            self.banner.frame = self.adView.bounds
            self.adView.addSubview(self.banner)
        }
        setupUI()
    }
    
    private func setupUI(){
        points = 0
        questionsCollectionView.delegate = self
        questionsCollectionView.dataSource = self
        questionsCollectionView.register(UINib(nibName: "NewQuestionsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewQuestionsCollectionViewCell")
        questionsCollectionView.isScrollEnabled = false
        self.categoryLbl.text = categoryStr
        
        viewModel?.getQuestions {
            DispatchQueue.main.async {
                self.questionsCollectionView.reloadData()
            }
        }
        backBtn.setTitle("", for: .normal)
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension QuestionsViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.getQuestionsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewQuestionsCollectionViewCell", for: indexPath) as? NewQuestionsCollectionViewCell else {return UICollectionViewCell()}
        if let object = self.viewModel?.getQuestion(index: indexPath.row){
            var model = object.options
            model = model.shuffled()
            cell.questionNumberLbl.text = "Question \(indexPath.row + 1)"
            cell.setupCell(element: object)
            cell.delegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: questionsCollectionView.frame.width, height: questionsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let collectionViewCenter = view.bounds.width / 2 + questionsCollectionView.contentInset.left
            for cell in questionsCollectionView.visibleCells {
                let cellCenter = questionsCollectionView.convert(cell.center, to: view)
                let distanceFromCenter = abs(collectionViewCenter - cellCenter.x)
                let maxDistance = view.bounds.width
                let scaleFactor = 1 - distanceFromCenter / maxDistance
                let alphaFactor = 1 - distanceFromCenter / (maxDistance * 0.5)
                let transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
                cell.transform = transform
                cell.alpha = alphaFactor
            }
        }
    
}

extension QuestionsViewController{
    
    func animateImageView(imageView: UIImageView) {
        UIView.animate(withDuration: 0.2, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in
            UIView.animate(withDuration: 0.2, animations: {
                imageView.transform = CGAffineTransform.identity
            })
        })
    }
    
}

extension QuestionsViewController:MyCollectionViewCellDelegateNew{
    func didTapButtonInCell(_ cell: NewQuestionsCollectionViewCell, points: Int) {
        if points > 0{
            self.points = self.points+points
        }
        guard let indexPath = questionsCollectionView.indexPath(for: cell) else { return }
        if let count = viewModel?.getQuestionsCount(){
            if indexPath.row < count - 1 {
                let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                    self.questionsCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                }
            }else{
                let vc = ResultViewController()
                if let count = viewModel?.getQuestionsCount(){
                    let percentage = calculatePercentage(marksObtained: Double(self.points), totalMarks: Double(count))
                    if percentage >= 50{
                        vc.configure(percentage: "\(percentage)% Score", congoString: "Congrats", colorHexCode: "#3CB572", animationString: "Celebration")
                    }else if percentage < 50{
                        vc.configure(percentage: "\(percentage)% Score", congoString: "Try Again", colorHexCode: "#FF5252", animationString: "tryAgain")
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    func calculatePercentage(marksObtained: Double, totalMarks: Double) -> Int {
        let marks = Int((marksObtained / totalMarks) * 100.0)
        return marks
    }
    
    
}
