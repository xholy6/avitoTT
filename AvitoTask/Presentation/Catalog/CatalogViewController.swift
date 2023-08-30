//
//  ViewController.swift
//  AvitoTask
//
//  Created by D on 27.08.2023.
//

import UIKit

final class CatalogViewController: UIViewController {

    private let viewModel = CatalogViewModel()

    private var selectedId = ""

    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CatalogCell.self,
                                forCellWithReuseIdentifier: CatalogCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activateConstraints()
        bind()
        view.backgroundColor = .white
    }
    //MARK: - Private
    private func bind() {
        viewModel.$ads.bind { [weak self] _ in
            self?.productsCollectionView.reloadData()
        }

        viewModel.$error.bind { [weak self] error in
            if case NetworkClientError.urlSessionError = error {
                self?.showAlert(with: "Возможно у вас проблемы с интернетом")
            } else {
                self?.showAlert(with: "Что то пошло не так")
            }
        }
    }

    private func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { [weak self] _ in
            self?.viewModel.fillAdsArray()}
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    private func showDetailsViewController() {
        let vc = DetailsViewController()
        vc.viewModel.itemIndex = selectedId
        print(vc.viewModel.itemIndex)
        present(vc, animated: true)
    }


    //MARK: - setupUI
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
//MARK: - UICollectionViewDelegate
extension CatalogViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let selectedAd = indexPath.item
        selectedId = viewModel.ads[selectedAd].id
        showDetailsViewController()
    }
}
//MARK: - UICollectionViewDataSource
extension CatalogViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.ads.count
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
        let ad = viewModel.ads[indexPath.item]

        let title = ad.title
        let location = ad.location
        let price = ad.price
        let date = ad.createdAt
        let imageURL = ad.image
        cell.configCell(title: title, location: location, price: price, date: date, image: imageURL)
        return cell
    }

}
//MARK: - UICollectionViewDelegateFlowLayout
extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 48) / 2
        let heightConstant: CGFloat = 300
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

