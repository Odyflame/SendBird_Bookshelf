//
//  BookCollectionViewCell.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/21.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thumbnailView, stackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    lazy var thumbnailView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "noimage")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.1
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, priceLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 3
        stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SubTitle"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 12)
        return label
    }()
    
    static let reuseIdentifier = "BookCVCIdentifier"
    
    var book: Book? {
        didSet {
            guard let url = URL(string: book?.image ?? "") else {
                return
            }
            thumbnailView.layer.cornerRadius = 20
            thumbnailView.load(url: url)
            titleLabel.text = book?.title
            subtitleLabel.text = book?.subtitle
            priceLabel.text = book?.price
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        //        addSubview(thumbnailView)
        //        addSubview(stackView)
        //
        //        NSLayoutConstraint.activate([
        //            thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //            thumbnailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //            thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor),
        //            thumbnailView.widthAnchor.constraint(equalTo: thumbnailView.heightAnchor),
        //
        //            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //            stackView.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor),
        //            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        //        ])
    }
}
