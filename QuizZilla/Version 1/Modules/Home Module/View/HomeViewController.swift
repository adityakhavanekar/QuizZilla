//
//  HomeViewController.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var questionLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.navigationController?.isNavigationBarHidden = true
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
        return 4
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
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://localhost:3000/historyQuestions")!)
        case 1:
            vc.categoryStr = "Sports"
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://localhost:3000/sportQuestions")!)
        case 2:
            vc.categoryStr = "Science"
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://localhost:3000/scienceQuestions")!)
        case 3:
            vc.categoryStr = "Music"
            vc.viewModel = QuestionsViewModel(url: URL(string: "http://localhost:3000/musicQuestions")!)
        default:
            print("")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
