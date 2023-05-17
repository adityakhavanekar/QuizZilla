//
//  HomeViewController.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import UIKit
import GoogleMobileAds

var didAnimate: Bool = false

class HomeViewController: UIViewController {

    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var adView: UIView!
    
    private let banner:GADBannerView = {
        let banner = GADBannerView()
//        ca-app-pub-8260816350989246/3781983591
//TESTAD: ca-app-pub-3940256099942544/2934735716
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
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
    override func viewDidAppear(_ animated: Bool) {
        if didAnimate == false{
            self.animateCollection()
        }
        self.homeCollectionView.isUserInteractionEnabled = true
    }
    
    private func setupUI(){
        self.navigationController?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        homeCollectionView.layer.cornerRadius = 30
        questionLbl.text = "Hey, What subject you want to play today?"
        homeCollectionView.dataSource = self
        homeCollectionView.delegate =  self
        homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        userImgView.isHidden = true
        menuImgView.isHidden = true
    }

}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        switch indexPath.item{
        case 0:
            cell.titleLbl.text = "History"
            cell.imgView.image = UIImage(named: "History")
        case 1:
            cell.titleLbl.text = "Sports"
            cell.imgView.image = UIImage(named: "Sports")
        case 2:
            cell.titleLbl.text = "Science"
            cell.imgView.image = UIImage(named: "Science")
        case 3:
            cell.titleLbl.text = "Music"
            cell.imgView.image = UIImage(named: "music")
        case 4:
            cell.titleLbl.text = "Movies"
            cell.imgView.image = UIImage(named: "movies")
        default:
            print("")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colWidth = self.homeCollectionView.frame.width
        return CGSize(width: colWidth/2 - 15, height: colWidth/1.8 - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = QuestionsViewController()
        switch indexPath.row{
        case 0:
            vc.categoryStr = "History"
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://207.154.204.149:3050/historyQuestions")!)
        case 1:
            vc.categoryStr = "Sports"
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://207.154.204.149:3050/sportQuestions")!)
        case 2:
            vc.categoryStr = "Science"
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://207.154.204.149:3050/scienceQuestions")!)
        case 3:
            vc.categoryStr = "Music"
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://207.154.204.149:3050/musicQuestions")!)
        case 4:
            vc.categoryStr = "Movies"
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://207.154.204.149:3050/movieQuestions")!)
        default:
            print("")
        }
        didAnimate = true
        self.homeCollectionView.isUserInteractionEnabled = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}


extension HomeViewController:UINavigationControllerDelegate, UIViewControllerTransitioningDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            if operation == .push {
                return CustomPushTransition()
            }
            return nil
        }
}

extension HomeViewController{
    func animateCollection() {
        homeCollectionView.isUserInteractionEnabled = false
        let cells = homeCollectionView.visibleCells
        let collectionViewWidth = homeCollectionView.bounds.size.width
        
        for (index, cell) in cells.enumerated() {
            let translationX = index % 2 == 0 ? -collectionViewWidth : collectionViewWidth
            cell.transform = CGAffineTransform(translationX: translationX, y: 0)
            cell.alpha = 0
        }
        
        var delayCounter = 0.0
        for (index, cell) in cells.enumerated() {
            UIView.animate(withDuration: 0.5, delay: delayCounter, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
                cell.alpha = 1
            }, completion: nil)
            
            delayCounter += 0.2
        }
        homeCollectionView.isUserInteractionEnabled = true
    }
}
