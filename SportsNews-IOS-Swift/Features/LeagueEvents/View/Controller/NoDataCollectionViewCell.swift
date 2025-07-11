//
//  NoDataCollectionViewCell.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 31/05/2025.
//

import UIKit

class NoDataCollectionViewCell: UICollectionViewCell {
    static let identifier = "NoDataCollectionViewCell"

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry,There is no mathces "
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
