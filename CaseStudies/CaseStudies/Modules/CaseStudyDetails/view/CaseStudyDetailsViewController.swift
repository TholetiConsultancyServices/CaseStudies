//
//  CaseStudyDetailsViewController.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 27/01/2021.
//

import Foundation
import UIKit

class CaseStudyDetailsViewController: UIViewController {

    var viewModel: CaseStudyDetailsViewModelType?
    private var tableHeaderView: CaseStudyDetailsTableHeaderView?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.title

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TableViewTextCell.self, forCellReuseIdentifier: TableViewTextCell.identifier)
        tableView.register(TableViewImageCell.self, forCellReuseIdentifier: TableViewImageCell.identifier)
        setUpHeader()
    }

    private func setUpHeader() {
        guard  let viewModel = viewModel else {
            return
        }
        tableHeaderView = CaseStudyDetailsTableHeaderView.fromNib()
        tableHeaderView?.setHeading(heading: viewModel.heading)
        tableView.tableHeaderView = tableHeaderView
        viewModel.fetchImage(imageURL: viewModel.mainImageURL, completion: { [weak self] image in
            guard let image = image else { return }
            self?.tableHeaderView?.updateImage(image: image)
        })

        tableHeaderView?.autoresizingMask = []
        tableView.tableHeaderView?.layoutIfNeeded()
    }
}

extension CaseStudyDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.text = viewModel?.sections[section].title
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel?.sections[section].title?.isEmpty == false {
            return 30
        }

        return 0
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.sections[section].items.count ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.sections[indexPath.section].items[indexPath.row] else {
            return UITableViewCell()
        }

        switch item {
        case .image(let url):
            if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewImageCell.identifier, for: indexPath) as? TableViewImageCell {
                viewModel?.fetchImage(imageURL: url, completion: { [weak self] image in
                    if (self?.tableView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                        cell.updateImage(image: image)
                    }
                })
                return cell
            }
        case .text(let text):
            if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewTextCell.identifier, for: indexPath) as? TableViewTextCell {
                cell.setText(text: text)
                return cell
            }
        }

        return UITableViewCell()
    }
}


extension CaseStudyDetailsViewController: StoryboardBased {
    static var storyboard: Storyboard = .main
}
