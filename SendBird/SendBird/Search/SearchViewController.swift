//
//  ViewController.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/20.
//

import UIKit

var hasTopNotch: Bool {
    return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
}

var bottomSafeInset: CGFloat {
    UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
}

class SearchViewController: UIViewController {
    
    enum Constant {
        static let spacing: CGFloat = 11
        static let topMargin: CGFloat = 44
    }
    
    // MARK: - Properties
    //private lazy var dataSource = makeDataSource()
    //private var sections = [Section(title: "New", books: []), Section(title: "Search", books: []),]

//    // MARK: - Value Types
//    typealias DataSource = UICollectionViewDiffableDataSource<Section, Book>
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Book>
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var books = [Book]()
    var page = 0
    var word = ""
    var refresher = UIRefreshControl()
    
    lazy var SearchCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = Constant.spacing
        flowLayout.minimumLineSpacing = Constant.spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            BookCollectionViewCell.self,
            forCellWithReuseIdentifier: BookCollectionViewCell.reuseIdentifier
        )
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        getNewBooksData()
        configureSearchController()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        word = ""
        page = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        word = ""
        page = 0
    }

    // MARK: - Method
    func getNewBooksData() {
        BookAPIManager.shared.getNewBooks { (BooksData) in
            guard let data = BooksData else {
                return
            }
            self.books = data.books ?? []
            DispatchQueue.main.async {
                self.SearchCollectionView.reloadData()
            }
        }
    }
    
    func getSearchBooksData(word: String) {
        
        if word == "" {
            return
        }
        
        BookAPIManager.shared.getSearchBooks(search: word) { (BooksData) in
            guard let data = BooksData else {
                return
            }
            self.books = data.books ?? []
            DispatchQueue.main.async {
                self.SearchCollectionView.reloadData()
            }
        }
    }
    
    func getSearchBooksDataWithPage(word: String, page: Int) {
        
        if word == "" {
            return
        }
        
        BookAPIManager.shared.getSearchBooks(search: word, page: page) { (BooksData) in
            guard let data = BooksData,
                  let dataBooks = data.books else {
                return
            }
            
            if dataBooks.count == 0 {
                return
            }
            
            self.books += dataBooks
            DispatchQueue.main.async {
                self.SearchCollectionView.reloadData()
            }
        }
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Books"
        navigationItem.largeTitleDisplayMode = .automatic
        definesPresentationContext = true
    }
    
    func configureLayout() {
        view.addSubview(SearchCollectionView)
        
        NSLayoutConstraint.activate([
            SearchCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            SearchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            SearchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            SearchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource Implementation
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseIdentifier, for: indexPath) as? BookCollectionViewCell else {
            return BookCollectionViewCell()
        }
        
        /**
         이 작업은 cellForRowAt 안에서 수행합니다. 즉, 목록에 표시할 셀을 요청할 때마다 이 방법이 해당 셀에 대해 호출됩니다. 따라서 부하와 취소는 세포의 수명 주기와 매우 밀접하게 연관되어 있습니다. 이 경우 우리가 원하는 것과 정확히 일치합니다.
         */
        cell.book = self.books[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailViewController(isbn13: self.books[indexPath.item].isbn13 ?? "")
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 32,
            left: 0,
            bottom: (hasTopNotch ? bottomSafeInset : 32),
            right: 0
        )
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.width - (11) - (16 * 2)) / 2
        return CGSize(width: width, height: width + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == self.books.count - 1 else {
            return
        }
        page += 1
        getSearchBooksDataWithPage(word: word, page: page)
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let word = searchController.searchBar.text else {
            return
        }
        self.word = word
        self.books = []
        getSearchBooksData(word: word)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.getNewBooksData()
    }
}

// MARK: - for pagination way 1
//extension ViewController {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let height: CGFloat = scrollView.frame.size.height
//        let contentYOffset: CGFloat = scrollView.contentOffset.y
//        let scrollViewHeight: CGFloat = scrollView.contentSize.height
//        let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
//
//        if distanceFromBottom < height {
//            page += 1
//            getSearchBooksData(word: word, page: page)
//        }
//    }
//}

// MARK: - for pagination way 3
//extension ViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            if self.books.count == indexPath.item {
//                page += 1
//                getSearchBooksData(word: word, page: page)
//            }
//        }
//    }
//}

// MARK: - if use DiffableDatasource to CollectionView...
//extension ViewController {
    //    func makeDataSource() -> DataSource {
    //        let dataSource = DataSource(collectionView: SearchCollectionView) { (collectionView, indexPath, book) -> UICollectionViewCell? in
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseIdentifier, for: indexPath) as? BookCollectionViewCell
    //            cell?.book = book
    //            return cell
    //        }
    //
    //        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
    //            guard kind == UICollectionView.elementKindSectionHeader else {
    //                return nil
    //            }
    //            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
    //            let view = collectionView.dequeueReusableSupplementaryView(
    //                ofKind: kind,
    //                withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier,
    //                for: indexPath) as? SectionHeaderReusableView
    //
    //            view?.titleLabel.text = section.title
    //            return view
    //        }
    //
    //        return dataSource
    //    }
    //
    //    func applySnapshot(animatingDifferences: Bool = true) {
    //        var snapShot = Snapshot()
    //
    //        //snapShot.appendSections()
    //    }
//}
