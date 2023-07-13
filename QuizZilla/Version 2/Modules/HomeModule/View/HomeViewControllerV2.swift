//
//  HomeViewControllerV2.swift
//  QuizZilla
//
//  Created by APPLE on 10/07/23.
//

import UIKit
import GoogleMobileAds

class HomeViewControllerV2: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var adView: UIView!
    
    private let banner:GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
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
        setupBannerAd()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.categoryView.roundCorners(corners: [.topRight,.topLeft], radius: 50)
            self.setupCollectionView()
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
        categoryCollectionView.register(UINib(nibName: HomeCells.categoryCell.rawValue, bundle: nil), forCellWithReuseIdentifier: HomeCells.categoryCell.rawValue)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
}

extension HomeViewControllerV2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCells.categoryCell.rawValue, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        switch indexPath.item{
        case 0:
            cell.titleLbl.text = Categories.history.rawValue
            cell.imgView.image = UIImage(named: Categories.history.rawValue)
        case 1:
            cell.titleLbl.text = Categories.sports.rawValue
            cell.imgView.image = UIImage(named: Categories.sports.rawValue)
        case 2:
            cell.titleLbl.text = Categories.science.rawValue
            cell.imgView.image = UIImage(named: Categories.science.rawValue)
        case 3:
            cell.titleLbl.text = Categories.music.rawValue
            cell.imgView.image = UIImage(named: Categories.music.rawValue)
        case 4:
            cell.titleLbl.text = Categories.movie.rawValue
            cell.imgView.image = UIImage(named: Categories.movie.rawValue)
        default:
            print("")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colWidth = self.categoryCollectionView.frame.width
        return CGSize(width: colWidth/2 - 15, height: colWidth/2 - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = QuestionsViewControllerV2()
        switch indexPath.row{
        case 0:
            vc.categoryStr = Categories.history.rawValue
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.history.url)
        case 1:
            vc.categoryStr = Categories.sports.rawValue
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.sports.url)
        case 2:
            vc.categoryStr = Categories.science.rawValue
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.science.url)
        case 3:
            vc.categoryStr = Categories.music.rawValue
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.music.url)
        case 4:
            vc.categoryStr = Categories.movie.rawValue
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.movie.url)
        default:
            print("")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - ADS:
// MARK: Banner:- ca-app-pub-8260816350989246/3781983591
//                TESTAD: ca-app-pub-3940256099942544/2934735716



