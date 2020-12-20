//
//  HomeView.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit

enum HomeViewAction{
    case showAlert
    case setTitle
}

class HomeView: View {
    private let tableView = UITableView()
    private var refreshController = UIRefreshControl()
    private var viewModel: ViewModel?
    
    /// tableview constraints
    private var constraint:Array<NSLayoutConstraint> {
        let top = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        return [top, bottom, left, right];
    }
    
    
    override func viewDidLoad() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.addSubview(tableView)
        viewModel = ViewModel()
        viewModel?.delegate = self
        applyConstraint()
    }
    
    override func viewDidAppear() {
        if Utility.main.isConnected {
            viewModel?.getList()
            self.showLoader()
        }else{
            self.delegate?.view(view: self, didPerformAction: HomeViewAction.showAlert, userInfo: "Please connect to network")
        }
    }
    
    /// add Constraint in table view
    private func applyConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(constraint)
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.setupRefreshController()
    }
    
    /// setup pul to refresh controller
    private func setupRefreshController() {
        self.refreshController.tintColor = UIColor.gray
        self.tableView.refreshControl = refreshController
        self.refreshController.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
    }
    
    ///pullToRefreshAction
    @objc func pullToRefreshAction() {
        if Utility.main.isConnected {
            viewModel?.getList()
        }else{
            self.delegate?.view(view: self, didPerformAction: HomeViewAction.showAlert, userInfo: "Please connect to network")
            self.refreshController.endRefreshing()
        }
    }
}

extension HomeView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CountryCell else {
            return
        }
        let countryInfoViewModel = self.viewModel?.country(indexPath.row)
        cell.setUpData(countryInfoViewModel!)
    }
    
    
}

extension HomeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell
        return cell ?? CountryCell()
    }
}

extension HomeView: ViewModelDelegate {
    
    /// api success call
    func success() {
        self.hideLoader()
        DispatchQueue.main.async {
            if self.refreshController.isRefreshing {
                self.refreshController.endRefreshing()
            }
            self.tableView.reloadData()
            self.delegate?.view(view: self, didPerformAction: HomeViewAction.setTitle, userInfo: self.viewModel?.getTitle())
        }
    }
    
    /// return some error
    /// - Parameter error: error
    func didReceiveError(error: Error?){
        self.hideLoader()
        DispatchQueue.main.async {
            self.delegate?.view(view: self, didPerformAction: HomeViewAction.showAlert, userInfo: error?.localizedDescription)
        }
    }
}
