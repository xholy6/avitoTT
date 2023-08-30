//
//  ViewController.swift
//  AvitoTask
//
//  Created by D on 27.08.2023.
//

import UIKit

final class CatalogViewController: UIViewController {

    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CatalogCell.self, forCellWithReuseIdentifier: CatalogCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activateConstraints()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }


    private func setupView() {
        view.addSubview(productsCollectionView)
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}

extension CatalogViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: CatalogCell.reuseIdentifier, for: indexPath
            ) as? CatalogCell
        else { return CatalogCell() }

        return cell
    }


}

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 48) / 2
        let heightConstant: CGFloat = 200
        let size = CGSize(width: width, height: heightConstant)
        return size
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        16
    }
}

