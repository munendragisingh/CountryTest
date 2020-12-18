//
//  ViewModel.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import Foundation

protocol ViewModelDelegate: class {
    func didReceiveCountryData()
    func didReceiveError(error: Error?)
}

class ViewModel {
    private let urlManager = URLManager()
    private let requestManager = RequestManager()
    private var countryListData: CountryListData?
    var delegate: ViewModelDelegate?
    
    var numberOfSection: Int {
        return 1
    }
    
    func getTitle() -> String {
        return self.countryListData?.title ?? "Title"
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let countryListData = countryListData, let countries = countryListData.countries else {
            return 0
        }
        return countries.count
    }
    
    func country(_ index: Int) -> CountryViewModel{
        let country = self.countryListData!.countries![index]
        return CountryViewModel(country: country)
    }
    
    func getList() {
        guard let url = URL(string: urlManager.countyFacts) else {
            let error = NSError(domain: "", code: 5001, userInfo: ["message":"Invalid URL"]) as Error
            self.delegate?.didReceiveError(error: error)
            return
        }
        
        requestManager.get(with: url) {  [weak self] (data, error) in
            guard let `self` = self else {
                return
            }
            if error == nil, let data = data {
                let decoder = JSONDecoder()
                do {
                    self.countryListData = try decoder.decode(CountryListData.self, from: data)
                    self.delegate?.didReceiveCountryData()
                } catch {
                    self.delegate?.didReceiveError(error: error)
                   }
            } else {
                self.delegate?.didReceiveError(error: error)
            }
        }
    }
}
