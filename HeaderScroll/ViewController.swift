//
//  ViewController.swift
//  HeaderScroll
//
//  Created by Raiden Yamato on 03.04.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {

  /// Метод логики отображения данных
  func displayCars(_ viewModel: HomeModels.FetchCars.ViewModel)
}



class ViewController: UIViewController, HomeDisplayLogic {
    
    let interactor = InternetService()
    let presenter = Presenter()
    
    var cars: Cars? {
        didSet {
            DispatchQueue.main.sync {
                tableView.reloadData()
            }
          
        }
    }
    
    func displayCars(_ viewModel: HomeModels.FetchCars.ViewModel) {
      cars = viewModel.cars
  }
    
    private var headerViewHeightConstraint: NSLayoutConstraint?
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .gray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
//    var numbersArray = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        request()
        interatorPresenterSetup()
    }
    
    func   interatorPresenterSetup() {
      
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    func request() {
        // MARK - dataRequest
        let internetRequest = InternetService()
        internetRequest.dataTaskMethod {[unowned self] cars in
            let model = HomeModels.FetchCars.Response(cars: cars)
                    self.presenter.presentCars(model)
        }
    }
    
    
    // MARK: Private
    private func calculateHeaderViewHeight(for currentOffset: CGFloat) {
        if currentOffset <= 0 {
            setHeaderViewHeight(for: headerView.maxHeight)
        } else {
            var newHeight = headerView.maxHeight - currentOffset
            if newHeight < headerView.minHeight {
                newHeight = headerView.minHeight
            }
            setHeaderViewHeight(for: newHeight)
        }
    }
    
    private func setHeaderViewHeight(for newHeight: CGFloat) {
        if headerViewHeightConstraint?.constant != newHeight {
            headerViewHeightConstraint?.constant = newHeight
            headerView.height = newHeight
        }
    }
    
    private func changeHeaderStateIfNeeded() {
        var offset = CGPoint(x: 0, y: -480)
        var tableContentInset: UIEdgeInsets = .zero
        offset = CGPoint(x: 0, y: -480)
        tableContentInset.top = 330
        tableView.contentInset = tableContentInset
        tableView.setContentOffset(offset, animated: true)
        setHeaderViewHeight(for: headerView.maxHeight)
        view.layoutIfNeeded()
    }
}

// MARK: SetupUI
extension ViewController {
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(headerView)
        
        view.backgroundColor = .white
        let headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: headerView.maxHeight)
        self.headerViewHeightConstraint = headerHeightConstraint
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerHeightConstraint,
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        changeHeaderStateIfNeeded()
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cars?.news.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var contentConfiguration = UIListContentConfiguration.sidebarCell()
        contentConfiguration.text = cars?.news[indexPath.row].title
        cell.contentConfiguration = contentConfiguration
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

// MARK: UIScrollView
extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y + scrollView.contentInset.top
        calculateHeaderViewHeight(for: currentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y + scrollView.contentInset.top
//        print("\(scrollView.contentOffset.y)     \(scrollView.contentInset.top)" )
        var offset: CGPoint = .zero
        
        let transition = UIViewPropertyAnimator(duration: 0.0, dampingRatio: 1) {
            if currentOffset < 170 {
                offset.y = -340
            } else {
                guard currentOffset < 276 else { return }
                offset.y = -230
            }
            DispatchQueue.main.async {
                self.tableView.setContentOffset(offset, animated: true)
                print("\(offset.y)")
            }
        }
        transition.startAnimation()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee.y = max(targetContentOffset.pointee.y - 1, 1)
    }
    
}

