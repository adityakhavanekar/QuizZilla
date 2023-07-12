//
//  QuestionsViewControllerV2.swift
//  QuizZilla
//
//  Created by APPLE on 11/07/23.
//

import UIKit

class QuestionsViewControllerV2: UIViewController {

    @IBOutlet weak var bannerAdView: UIView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var questionCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    var categoryStr: String = ""
    var viewModel:QuestionsViewModelV2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        categoryLbl.text = categoryStr
        backButton.applyLiftedShadowEffect(cornerRadius: backButton.frame.height/2)
        setupCollectionView()
        viewModel?.getQuestions {
            DispatchQueue.main.async {
                self.questionCollectionView.reloadData()
            }
        }
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
        return viewModel?.getQuestionsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = questionCollectionView.dequeueReusableCell(withReuseIdentifier: "QuestionsCollectionViewCellV2", for: indexPath) as! QuestionsCollectionViewCellV2
        if let data = viewModel?.getQuestion(index: indexPath.row){
            var model = data
            model.options.shuffle()
            cell.setupCell(model: model)
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
