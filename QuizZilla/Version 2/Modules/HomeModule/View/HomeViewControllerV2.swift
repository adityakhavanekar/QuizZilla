//
//  HomeViewControllerV2.swift
//  QuizZilla
//
//  Created by APPLE on 10/07/23.
//

import UIKit

class HomeViewControllerV2: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.categoryView.roundCorners(corners: [.topRight,.topLeft], radius: 50)
            self.setupCollectionView()
        }
    }
    
    private func setupCollectionView(){
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
}

extension HomeViewControllerV2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
