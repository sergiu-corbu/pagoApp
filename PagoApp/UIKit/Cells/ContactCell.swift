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
    
    let profileImageView: UIImageView
    let arrowImageView: UIImageView
    let userNameLabel: UILabel
    var stackView: UIStackView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        profileImageView = UIImageView(image: UIImage(named: "test"))
        userNameLabel = UILabel()
        arrowImageView = UIImageView(
            image: UIImage(systemName: "chevron.right")?.withTintColor(.wildBlueYonder, renderingMode: .alwaysOriginal)
        )
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        //MARK: Username label setup
        userNameLabel.textColor = .black
        userNameLabel.font = .systemFont(ofSize: 17, weight: .regular)
        userNameLabel.frame.size = CGSize(width: 200, height: 40)
        userNameLabel.numberOfLines = 1
        userNameLabel.lineBreakMode = .byClipping
        
        //MARK: ArrowImage setup
        arrowImageView.frame.size = CGSize(width: 16, height: 9)
        arrowImageView.contentMode = .scaleAspectFit
        
        //MARK: ProfileImage label setup
        profileImageView.frame = CGRect(origin: .zero, size: CGSize(width: 46, height: 46))
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 46),
        ])
        
        //MARK: StackView setup
        let stackView = UIStackView(arrangedSubviews: [profileImageView, userNameLabel, arrowImageView])
        self.stackView = stackView
        
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
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
}

extension ContactCell {
    
    static let cellReuseIdentifier = "contactCellReuseIdentifier"
}
