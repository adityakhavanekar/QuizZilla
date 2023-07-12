//
//  QuestionsViewControllerV2.swift
//  QuizZilla
//
//  Created by APPLE on 11/07/23.
//

import UIKit

class QuestionsViewControllerV2: UIViewController {

    @IBOutlet weak var questionCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        backButton.applyLiftedShadowEffect(cornerRadius: backButton.frame.height/2)
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        questionCollectionView.register(UINib(nibName: "QuestionsCollectionViewCellV2", bundle: nil), forCellWithReuseIdentifier: "QuestionsCollectionViewCellV2")
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension QuestionsViewControllerV2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = questionCollectionView.dequeueReusableCell(withReuseIdentifier: "QuestionsCollectionViewCellV2", for: indexPath) as! QuestionsCollectionViewCellV2
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
