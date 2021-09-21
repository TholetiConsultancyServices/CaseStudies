//
//  CaseStudyDetailsTableViewCell.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 27/01/2021.
//

import Foundation
import UIKit

class TableViewTextCell: UITableViewCell {

    static let identifier = String(describing: TableViewTextCell.self)
  
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func setUpViews() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.95),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    func setText(text: String) {
        titleLabel.text = text
    }
}

class TableViewImageCell: UITableViewCell {

    static let identifier = String(describing: TableViewImageCell.self)

    private lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.isHidden = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
        photoView.isHidden = true
    }

    func setUpViews() {
        contentView.addSubview(photoView)
        contentView.backgroundColor = .black
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor,  constant: 10),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            photoView.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.9),
            photoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])

       setImageHeightConstraint()
    }

    func updateImage(image: UIImage?) {
        photoView.image = image
        photoView.isHidden = false
    }

    private func setImageHeightConstraint() {
        let heightConstraint = photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: 9.0/16.0)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
    }
}
