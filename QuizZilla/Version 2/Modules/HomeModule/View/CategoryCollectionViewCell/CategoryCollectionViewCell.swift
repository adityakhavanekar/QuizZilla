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
        innerView.applyLiftedShadowEffectToView(cornerRadius: 15)
    }
    
    func configureCell(title:String,imageName:String){
        titleLbl.text = title
        imgView.image = UIImage(named: imageName)
    }

}
