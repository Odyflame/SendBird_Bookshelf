//
//  DetailViewController.swift
//  SendBird
//
//  Created by apple on 2021/03/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum Constant {
        static let textViewPlaceholder = "여기에 아무거나 입력해주세요!"
    }
    
    var isbn13: String
    var detailBook: Book?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        view.image = UIImage(named: "noimage")
        return view
    }()
    
    lazy var stackTitleView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel, descLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 5
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
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "descsdfsdfadsfasdf fdsafd fsad fsda fsd f sdafadsf a dsf sadf saf ds ew fsdaf as wq fsa fsd fa  dsfads  adsf"
        label.numberOfLines = 3
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
        
        congigureLayout()
    }
    
    func congigureLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(imageView)
        scrollContentView.addSubview(stackTitleView)
        scrollContentView.addSubview(noteTextView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.heightAnchor.constraint(equalToConstant: view.frame.height + 200),
            scrollContentView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            imageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackTitleView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            stackTitleView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            stackTitleView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            noteTextView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            noteTextView.topAnchor.constraint(equalTo: stackTitleView.bottomAnchor),
            noteTextView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
        ])
    }
    
    func getDetailData() {
        BookAPIManager.shared.getDetailBook(isbn13: self.isbn13) { (Book) in
            guard let data = Book else {
                return
            }
            
            self.detailBook = data
        }
    }
    
    
}

extension DetailViewController: UITextViewDelegate {
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constant.textViewPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}
