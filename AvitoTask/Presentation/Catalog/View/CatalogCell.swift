//
//  CatalogCell.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import UIKit

final class CatalogCell: UICollectionViewCell {

    static let reuseIdentifier = "catalogCell"

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
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
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configCell() {
        
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
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edge),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edge),
            productImageView.heightAnchor.constraint(equalToConstant: 160),

            labelsStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edge),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edge),
            ])
    }
}
