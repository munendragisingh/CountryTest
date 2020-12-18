//
//  HomeView.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit

enum HomeViewAction{
    case showAlert
}

class HomeView: View {
    let tableView = UITableView()
    private var refreshController = UIRefreshControl()
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        self.addSubview(tableView)
        viewModel = ViewModel()
        viewModel?.delegate = self
        viewModel?.getList()
        self.showLoader()
        applyConstraint()
    }
    
    private func applyConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        self.addConstraints([top, bottom, left, right])

        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.setupRefreshController()
    }
    private func setupRefreshController() {
        self.refreshController.tintColor = UIColor.gray
        self.tableView.refreshControl = refreshController
        self.refreshController.addTarget(self, action: #selector(pullToRefreshCountryData), for: .valueChanged)
    }
    
    @objc func pullToRefreshCountryData() {
        viewModel?.getList()
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
    func didReceiveCountryData() {
        DispatchQueue.main.async {
            if self.refreshController.isRefreshing {
                self.refreshController.endRefreshing()
            }
            self.tableView.reloadData()
            self.delegate?.view(view: self, didPerformAction: HomeViewAction.showAlert, userInfo: "success")
            self.hideLoader()
        }
    }
    
    func didReceiveError(error: Error?){
        DispatchQueue.main.async {
            self.hideLoader()
            self.delegate?.view(view: self, didPerformAction: HomeViewAction.showAlert, userInfo: error?.localizedDescription)
        }
    }
}
