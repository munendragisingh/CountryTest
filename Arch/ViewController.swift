//
//  ViewController.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit


class ViewController: UIViewController {
    let new = URLManager()
    let req = RequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContactData()
    }
    
    /// this will return list of User
    /// - Parameter complition: user list, error
    func getContactData( ) {
        
        guard let url = URL(string: new.countyFacts) else {
            return
        }
        
        req.get(with: url) { (data, error) in
            if error == nil, let data = data {
                let decoder = JSONDecoder()
                do {
                       let countryList = try decoder.decode(CountryListData.self, from: data)
                       print(countryList)
                
                   } catch {
                       print(error)
                   }
            } else {
            }
        }
    }


}

