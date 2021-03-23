//
//  DetailViewController.swift
//  SendBird
//
//  Created by apple on 2021/03/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum Constant {
        enum Title {
            static let detailTitle = "Book Detail"
        }
        static let textViewPlaceholder = "여기에 아무거나 입력해주세요!"
        static let descLabelPlaceholder = "this is just for Testing, so please check them.."
    }
    
    var isbn13: String
    var detailBook: Book?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    lazy var scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [ratingLabel, yearLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "noImage")
        view.backgroundColor = .systemPink
        return view
    }()
    
    lazy var stackTitleView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel, descLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.layer.cornerRadius = 20
        stack.distribution = .fillProportionally
        stack.backgroundColor = .blue
        return stack
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SubTitle"
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constant.descLabelPlaceholder
        label.numberOfLines = 4
        return label
    }()
    
    lazy var noteTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.text = Constant.textViewPlaceholder
        view.textColor = .lightGray
        return view
    }()
    
    init(isbn13: String) {
        self.isbn13 = isbn13
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = Constant.Title.detailTitle
        congigureLayout()
        getDetailData()
    }
    
    func congigureLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(imageView)
        scrollContentView.addSubview(stackTitleView)
        scrollContentView.addSubview(noteTextView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            scrollContentView.heightAnchor.constraint(equalToConstant: view.frame.height + 200),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollContentView.widthAnchor),
            
            stackTitleView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10),
            stackTitleView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -10),
            stackTitleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            stackTitleView.heightAnchor.constraint(equalToConstant: 200),
            
            noteTextView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            noteTextView.topAnchor.constraint(equalTo: stackTitleView.bottomAnchor, constant: 10),
            noteTextView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
        ])
    }
    
    func getDetailData() {
        BookAPIManager.shared.getDetailBook(isbn13: self.isbn13) { (Book) in
            guard let data = Book else {
                return
            }
            
            DispatchQueue.main.async {
                self.detailBook = data
                
                self.titleLabel.text = data.title
                self.descLabel.text = data.desc
                self.subTitleLabel.text = data.subtitle
                guard let imageURL = URL(string: data.image ?? "noimage") else {
                    return
                }
                self.imageView.load(url: imageURL)
            }
        }
    }
    
    
}

extension DetailViewController: UITextViewDelegate {
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .systemPink
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constant.textViewPlaceholder
            textView.textColor = .lightGray
        }
    }
}
