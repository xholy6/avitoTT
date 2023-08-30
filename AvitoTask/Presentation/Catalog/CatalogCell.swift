//
//  CatalogCell.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import UIKit
import Kingfisher

final class CatalogCell: UICollectionViewCell {

    static let reuseIdentifier = "catalogCell"

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        activateConstraints()
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configCell(title: String, location: String, price: String, date: String, image: String) {
        titleLabel.text = title
        priceLabel.text = price
        locationLabel.text = location
        dateLabel.text = date
        guard let url = URL(string: image) else { return }
        productImageView.kf.indicatorType = .activity
        self.downloadImage(with: url)
    }

    private func downloadImage(with url: URL) {
        productImageView.kf.setImage(with: url, options: nil) { [weak self] result in
            switch result {
            case .success(let value):
                self?.productImageView.image = value.image
            case .failure(_):
                break
            }
        }
    }

    private func setupView() {
        let labels = [titleLabel, priceLabel, locationLabel, dateLabel]
        labels.forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        labels.forEach {labelsStackView.addArrangedSubview($0)}
        contentView.addSubview(labelsStackView)
        contentView.addSubview(productImageView)
    }

    private func activateConstraints() {
        let edge: CGFloat = 16
        NSLayoutConstraint.activate([

            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: labelsStackView.topAnchor, constant: -10),

            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor ),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -edge)
        ])
    }
}
