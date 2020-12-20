//
//  CountryCell.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit

class CountryCell: UITableViewCell {
    // contentHolderView holds all the elements in cell
    private let cardView: UIView = UIView()
    private let title: UILabel = UILabel()
    private let countryDescription: UILabel = UILabel()
    
    private let countryImage: ImageLoader = {
        let imgView = ImageLoader(image: UIImage(named: "placeHolder"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.selectionStyle = .none
        
        self.contentView.addSubview(cardView)
        cardView.addSubview(countryImage)
        cardView.addSubview(title)
        cardView.addSubview(countryDescription)
        setupCardView()
        setupcountryImage()
        addLabelConstraints()
        self.setTheme()
    }
    
    override func prepareForReuse() {
        self.countryImage.image = UIImage()
        self.title.text = ""
        self.countryDescription.text = ""
    }
    
    /// set text theme
    private func setTheme() {
        title.numberOfLines = 0
        countryDescription.numberOfLines = 0
        self.title.font = UIFont(name: "Helvetica-Bold", size: 18)
        self.countryDescription.font = UIFont(name: "Helvetica-Light", size: 15)
        self.title.textColor = UIColor.black
        self.countryDescription.textColor = UIColor.lightGray
    }
    
    /// set cell data
    /// - Parameter viewModel: CountryViewModel
    func setUpData(_ viewModel: CountryViewModel) {
        if let imgUrl = URL(string: viewModel.imgUrl) {
            countryImage.loadImageWithUrl(url: imgUrl,placeHolderImage: UIImage(named: "placeHolder"))
        }
        title.text = viewModel.title
        countryDescription.text = viewModel.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// set sell views
extension CountryCell {
    /// set card view and add constraints
    fileprivate func setupCardView() {
        cardView.layer.borderWidth = 1.0
        cardView.layer.borderColor = UIColor.purple.cgColor
        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: cardView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: cardView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: cardView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: cardView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    /// set verticalStack and  and add constraints
    fileprivate func setupcountryImage() {
        countryImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: countryImage, attribute: .leading, relatedBy: .equal, toItem: self.cardView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: countryImage, attribute: .top, relatedBy: .equal, toItem: self.cardView, attribute: .top, multiplier: 1, constant: 10).isActive = true
        
        NSLayoutConstraint(item: countryImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90).isActive = true
        NSLayoutConstraint(item: countryImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90).isActive = true
        countryImage.clipsToBounds = true
    }
    
    /// set horizontal, vertical Stack and add constraints
    fileprivate func addLabelConstraints() {
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: title, attribute: .leading, relatedBy: .equal, toItem: self.countryImage, attribute: .trailing, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: title, attribute: .trailing, relatedBy: .equal, toItem: self.cardView, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: self.cardView, attribute: .topMargin, multiplier: 1, constant: 10).isActive = true
        
        countryDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: countryDescription, attribute: .leading, relatedBy: .equal, toItem: self.countryImage, attribute: .trailing, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: countryDescription, attribute: .trailing, relatedBy: .equal, toItem: self.cardView, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: countryDescription, attribute: .top, relatedBy: .equal, toItem: self.title, attribute: .topMargin, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: countryDescription, attribute: .bottom, relatedBy: .equal, toItem: self.cardView, attribute: .bottomMargin, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: countryDescription, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
    }
}
