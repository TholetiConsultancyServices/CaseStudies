//
//  CaseStudyCollectionViewCell.swift
//  TheCaseStudyDB
//
//  Created by Appaji Tholeti on 27/01/2021.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit


class CaseStudyCollectionViewCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: String(describing: CaseStudyCollectionViewCell.self), bundle: nil)
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    static let reuseIdentifier = String(describing: CaseStudyCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        headingLabel.text = nil
        subtitleLabel.text = nil
        imageView.image = nil
        imageView.image = UIImage(named: "placeholder_image")
    }
    
    func applyViewModel(_ model: CaseStudyCollectionViewModel.CaseStudyItem) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        headingLabel.text = model.heading
    }
    
    func updateImage(image: UIImage) {
        imageView.image = image
    }
}
