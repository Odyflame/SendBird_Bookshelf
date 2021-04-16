//
//  DetailViewController.swift
//  SendBird
//
//  Created by apple on 2021/03/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Constant value
    enum Constant {
        enum Title {
            static let detailTitle = "Book Detail"
        }
        static let textViewPlaceholder = "여기에 아무거나 입력해주세요!"
        static let descLabelPlaceholder = "this is just for Testing, so please check them.."
        
        enum SaveButtonTitle: String {
            case add = "Add"
            case update = "Update"
        }
        static let deleteButtonTitle = "Delete"
    }
    
    // MARK: - Properties
    var isbn13: String
    var detailBook: Book?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var stackTitleView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel, descLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.layer.cornerRadius = 15
        stack.distribution = .fillProportionally
        stack.backgroundColor = .lightGray
        stack.layer.shadow(
            color: UIColor(red: 138.0 / 255.0, green: 149.0 / 255.0, blue: 158.0 / 255.0, alpha: 1),
            alpha: 0.2,
            x: 0,
            y: 10,
            blur: 60,
            spread: 0
        )
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

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
        view.text = Constant.textViewPlaceholder
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Constant.SaveButtonTitle.add.rawValue, style: .plain, target: self, action: #selector(tapSave))
        return  button
    }()
    
    var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Constant.deleteButtonTitle, style: .plain, target: self, action: #selector(tapDelete))
        return  button
    }()
    
    // MARK: - View init
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
        view.backgroundColor = .systemGray6
        noteTextView.delegate = self
        setNaviViewUI()
        congigureLayout()
        getDetailData()
        getNote()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name:UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name:UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    // MARK: - functions for ViewControllers
    
    func setNaviViewUI() {
        self.navigationItem.rightBarButtonItems = [saveButton, deleteButton]
    }
    
    func congigureLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(imageView)
        scrollContentView.addSubview(stackTitleView)
        scrollContentView.addSubview(noteTextView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
            
            noteTextView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10),
            noteTextView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -10),
            noteTextView.topAnchor.constraint(equalTo: stackTitleView.bottomAnchor, constant: 10),
            noteTextView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -5),
        ])
    }
    
    func getDetailData() {
        BookAPIManager.shared.getDetailBook(isbn13: self.isbn13) { (Book) in
            guard let data = Book else {
                return
            }
            
            self.detailBook = data
            
            DispatchQueue.main.async {
                
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
    
    func getNote() {
        print(isbn13)
        CoreDataManager.sharedManger.getNote(isbn13: isbn13) { result in
            
            guard let getNote = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.noteTextView.text = getNote.note
                self.noteTextView.textColor = .systemOrange
                self.saveButton.title = Constant.SaveButtonTitle.update.rawValue
            }
        }
    }
    
    @objc func tapSave(sender: UIBarButtonItem) {
        let note = NoteData(isbn13: detailBook?.isbn13, note: noteTextView.text)
        
        if saveButton.title == Constant.SaveButtonTitle.add.rawValue {
            let command = CoreDataManager.sharedManger.add(newNote: note)
            if command.0 == true {
                saveButton.title = Constant.SaveButtonTitle.update.rawValue
            }
        } else {
            CoreDataManager.sharedManger.update(updateNote: note)
        }

    }
    
    @objc func tapDelete(sender: UIBarButtonItem) {
        CoreDataManager.sharedManger.delete(isbn13: detailBook?.isbn13 ?? "")
        noteTextView.text = ""
    }
    
    @objc func tapImage(_ sender: UITapGestureRecognizer) {
        
        guard let urlString = detailBook?.url,
              let url = URL(string: urlString) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:])
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        // 이 코드는 스크롤뷰 내에서 스크롤뷰를 올릴 때 사용한다.
        // 지금 프로젝트는 뷰 자체를 올릴 것이기 때문에 이것은 쓰지 않는다.
        //        guard let userInfo = notification.userInfo else { return }
        //        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        //        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        //
        //        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        //        contentInset.bottom = keyboardFrame.size.height + 20
        //        scrollView.contentInset = contentInset
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        // 스크롤뷰를 올릴 때 사용
        //        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        //        scrollView.contentInset = contentInset
        
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension DetailViewController: UITextViewDelegate {
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .systemOrange
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
