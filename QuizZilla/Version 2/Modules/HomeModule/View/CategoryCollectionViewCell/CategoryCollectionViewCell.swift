//
//  CategoryCollectionViewCell.swift
//  QuizZilla
//
//  Created by APPLE on 10/07/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        innerView.layer.shadowColor = UIColor.black.cgColor
        innerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        innerView.layer.shadowOpacity = 0.3
        innerView.layer.shadowRadius = 6
        innerView.layer.masksToBounds = false
        innerView.layer.cornerRadius = 8
    }

}
