//
//  CaseStudyCollectionViewController.swift
//  TheCaseStudyDB
//
//  Created by Appaji Tholeti on 27/01/2021.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import UIKit

class CaseStudyCollectionViewController: UIViewController {
    
    var viewModel: CaseStudyCollectionViewModelType?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private func flowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        return flowLayout
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.title
        collectionView.collectionViewLayout = flowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CaseStudyCollectionViewCell.nib, forCellWithReuseIdentifier: CaseStudyCollectionViewCell.reuseIdentifier)
        loadCaseStudies()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadCaseStudies))
    }

    
    @objc private func loadCaseStudies() {
        guard let viewModel = viewModel else { return }
        
        disableControls()
         viewModel.loadCaseStudies(completion: {[weak self] (status) in
            guard let strongSelf = self else { return }
            
            strongSelf.enableControls()
            switch status {
            case .successful:
                strongSelf.collectionView.reloadData()
            case .failure(let error):
                strongSelf.present(withTitle: "Download Error", description: error)
                break
            }
        })
    }
    
    private func enableControls() {
        activityIndicator.stopAnimating()
    }
    
    private func disableControls() {
        activityIndicator.startAnimating()
    }
}

extension CaseStudyCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 40)/2
        let height = (collectionView.bounds.width)/2

        return CGSize(width: width, height: height)
    }
}

extension CaseStudyCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelect(indexPath: indexPath)
    }
}

extension CaseStudyCollectionViewController: UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CaseStudyCollectionViewCell.reuseIdentifier, for: indexPath) as? CaseStudyCollectionViewCell,
              let caseStudies = viewModel?.caseStudies else {
            return UICollectionViewCell()
        }

        let model = caseStudies[indexPath.row]
        cell.applyViewModel(model)

        viewModel?.fetchImage(imageURL: model.imageURL, completion: { [weak self] image in
            guard let image = image else { return }
            if (self?.collectionView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                cell.updateImage(image: image)
            }
        })

        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.caseStudies?.count ?? 0
    }
}


extension CaseStudyCollectionViewController: StoryboardBased {
    static var storyboard: Storyboard = .main
}
