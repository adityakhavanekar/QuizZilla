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
        setupBannerAd()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.categoryView.roundCorners(corners: [.topRight,.topLeft], radius: 50)
            self.setupCollectionView()
        }
    }
    
    private func setupBannerAd(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
//            self.banner.rootViewController = self
//            self.banner.frame = self.adView.bounds
//            self.adView.addSubview(self.banner)
        }
    }
    
    private func setupCollectionView(){
        categoryCollectionView.register(UINib(nibName: CollectionViewCells.categoryCell, bundle: nil), forCellWithReuseIdentifier: CollectionViewCells.categoryCell)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
}

extension HomeViewControllerV2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.categoryCell, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        switch indexPath.item{
        case 0:
            cell.configureCell(title: Categories.history, imageName: Images.history)
        case 1:
            cell.configureCell(title: Categories.sports, imageName: Images.sports)
        case 2:
            cell.configureCell(title: Categories.science, imageName: Images.science)
        case 3:
            cell.configureCell(title: Categories.music, imageName: Images.music)
        case 4:
            cell.configureCell(title: Categories.movie, imageName: Images.movie)
        default:
            print("")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colWidth = categoryCollectionView.frame.width
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
            vc.categoryStr = Categories.history
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.history.url)
        case 1:
            vc.categoryStr = Categories.sports
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.sports.url)
        case 2:
            vc.categoryStr = Categories.science
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.science.url)
        case 3:
            vc.categoryStr = Categories.music
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.music.url)
        case 4:
            vc.categoryStr = Categories.movie
            vc.viewModel = QuestionsViewModelV2(url: APIEndpoints.movie.url)
        default:
            print("")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
