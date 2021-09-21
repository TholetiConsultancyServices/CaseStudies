//
//  CaseStudyDetailsTableHeaderView.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 27/01/2021.
//

import Foundation
import UIKit

class CaseStudyDetailsTableHeaderView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    func updateImage(image: UIImage?) {
        guard let image = image else { return }
        imageView.image = image

        let newHeight = (image.size.height/image.size.width) * frame.width
        imageHeightConstraint.constant = newHeight
        layoutIfNeeded()
    }

    func setHeading(heading: String?) {
        titleLabel.text = heading
    }
}
