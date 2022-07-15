//
//  ContactCell.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation
import UIKit

class ContactCell: UITableViewCell {
    
    var contact: Contact? {
        didSet {
            userNameLabel.text = contact?.name
        }
    }
    
    var profileImageView: UIImageView
    var userNameLabel: UILabel
    let arrowImageView: UIImageView
    
    let stackView: UIStackView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        profileImageView = UIImageView(image: nil)
        userNameLabel = UILabel()
        arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(.wildBlueYonder, renderingMode: .alwaysOriginal))
        self.stackView = UIStackView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userNameLabel.textColor = .black
        userNameLabel.font = .systemFont(ofSize: 17, weight: .regular)
        userNameLabel.frame.size = CGSize(width: 200, height: 40)
        userNameLabel.numberOfLines = 1
        userNameLabel.lineBreakMode = .byClipping
        
        arrowImageView.frame.size = CGSize(width: 16, height: 9)
        arrowImageView.contentMode = .scaleAspectFit
        
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.alignment = .fill
        
        profileImageView.frame = CGRect(origin: .zero, size: CGSize(width: 46, height: 46))
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
    
        profileImageView.layer.borderColor = UIColor.red.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 46),
            profileImageView.widthAnchor.constraint(equalToConstant: 46)
        ])
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(arrowImageView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 94)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
}

extension ContactCell {
    
    static let cellReuseIdentifier = "contactCellReuseIdentifier"
}
