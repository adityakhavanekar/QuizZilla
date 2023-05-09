//
//  QuestionsViewController.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var questionsCollectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    
    var viewModel : QuestionsViewModel?
    var categoryStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.categoryLbl.text = categoryStr
        viewModel?.getQuestions {
            DispatchQueue.main.async {
                self.questionsCollectionView.reloadData()
            }
        }
    }
    
    private func setupUI(){
        questionsCollectionView.delegate = self
        questionsCollectionView.dataSource = self
        questionsCollectionView.register(UINib(nibName: "QuestionsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QuestionsCollectionViewCell")
        questionsCollectionView.isScrollEnabled = false
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionsCollectionViewCell", for: indexPath) as? QuestionsCollectionViewCell else {return UICollectionViewCell()}
        if let object = self.viewModel?.getQuestion(index: indexPath.row){
            var model = object.options
            model = model.shuffled()
            cell.correctAns = object.ca
            cell.questionNumberLbl.text = "Question \(indexPath.row + 1)"
            cell.questionLbl.text = object.question
            cell.option1Btn.setTitle(model[0], for: .normal)
            cell.option2Btn.setTitle(model[1], for: .normal)
            cell.option3Btn.setTitle(model[2], for: .normal)
            cell.option4Btn.setTitle(model[3], for: .normal)
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
    
    
}

extension QuestionsViewController: MyCollectionViewCellDelegate{
    func didTapButtonInCell(_ cell: QuestionsCollectionViewCell) {
        guard let indexPath = questionsCollectionView.indexPath(for: cell) else { return }
        if let count = viewModel?.getQuestionsCount(){
            if indexPath.row < count - 1 {
                let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                questionsCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            }
        }
        
    }
}
