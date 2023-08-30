//
//  DetailsViewController.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import UIKit
import Kingfisher

final class DetailsViewController: UIViewController {
    var viewModel = DetailsViewModel()

    var selectedItem: Int = .zero

    private var phoneNumber: String = ""

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = .zero
        return stack
    }()

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = .zero
        return label

    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = .zero
        label.textAlignment = .left
        return label
    }()

    private lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .aGreen
        button.setTitle("Позвонить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        activateConstraints()
        bind()
        viewModel.fetchAd()
    }

    private func bind() {
        viewModel.$advertisement.bind { [weak self] ad in
            guard let ad else { return }
            self?.phoneNumber = ad.phoneNumber
            self?.titleLabel.text = ad.title
            self?.dateLabel.text = ad.createdAt
            self?.locationLabel.text = ad.location + ", " + ad.address
            self?.descriptionLabel.text = ad.description
            self?.priceLabel.text = ad.price
            self?.emailLabel.text = ad.email
            guard let url = URL(string: ad.image) else { return }
            self?.photoImageView.kf.indicatorType = .activity
            self?.photoImageView.kf.setImage(with: url)
        }

        viewModel.$error.bind { [weak self] error in
            if case NetworkClientError.urlSessionError = error {
                self?.showAlert(with: "Возможно у вас проблемы с интернетом")
            } else {
                self?.showAlert(with: "Что то пошло не так")
            }
        }
    }

    @objc
    private func phoneButtonTapped() {
        phoneButton.setTitle(phoneNumber, for: .normal)
    }

    private func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { [weak self] _ in
            self?.viewModel.fetchAd()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    //MARK: - Setup UI
    private func setupView() {
        let labels = [titleLabel,priceLabel,phoneButton,
                      descriptionLabel, emailLabel, locationLabel, dateLabel]
        labels.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        labels.forEach { stackView.addArrangedSubview($0)}
        view.addSubview(photoImageView)
        view.addSubview(stackView)

    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 300),

            phoneButton.heightAnchor.constraint(equalToConstant: 60),

            stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
    }
}
