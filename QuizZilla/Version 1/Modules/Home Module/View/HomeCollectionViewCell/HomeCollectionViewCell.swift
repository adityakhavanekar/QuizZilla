//
//  HomeCollectionViewCell.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
        imgView.layer.cornerRadius = 15
        contView.layer.cornerRadius = 15
        contView.layer.shadowColor = UIColor.gray.cgColor
        contView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contView.layer.shadowOpacity = 0.2
        contView.layer.shadowRadius = 5
        contView.layer.masksToBounds = false
    }

}
