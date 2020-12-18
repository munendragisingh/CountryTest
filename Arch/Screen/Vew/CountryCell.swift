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
    private let verticalStack: UIStackView = UIStackView()
    private let title: UILabel = UILabel()
    private let countryDescription: UILabel = UILabel()
    private let horizontalStack: UIStackView = UIStackView()
    
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
        
        addSubview(cardView)
        cardView.addSubview(countryImage)
        
        setupCardView()
        setupcountryImage()
        setupStack()
    }
    
    override func prepareForReuse() {
        self.countryImage.image = UIImage()
        self.title.text = ""
        self.countryDescription.text = ""
    }
    
    private func setLabelStyles() {
        title.numberOfLines = 0
        countryDescription.numberOfLines = 0
        self.setTextColor()
        self.setFont()
    }
    
    private func setFont() {
        self.title.font = UIFont(name: "Helvetica-Bold", size: 18)
        self.countryDescription.font = UIFont(name: "Helvetica-Light", size: 15)
    }
    
    private func setTextColor() {
        self.title.textColor = UIColor.black
        self.countryDescription.textColor = UIColor.lightGray
    }
    
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

extension CountryCell {
    fileprivate func setupCardView() {
        cardView.layer.borderWidth = 1.0
        cardView.layer.borderColor = UIColor.purple.cgColor
        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setupcountryImage() {
        countryImage.translatesAutoresizingMaskIntoConstraints = false
        countryImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        countryImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        countryImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        countryImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        countryImage.clipsToBounds = true
    }
    

    fileprivate func setupStack() {
        verticalStack.addArrangedSubview(title)
        verticalStack.addArrangedSubview(countryDescription)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.distribution = .fill
        verticalStack.spacing = 10
        verticalStack.alignment = .top
        verticalStack.isLayoutMarginsRelativeArrangement = true
        verticalStack.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5)

        horizontalStack.addArrangedSubview(countryImage)
        horizontalStack.addArrangedSubview(verticalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .top
        horizontalStack.spacing = 10
        cardView.addSubview(horizontalStack)
        
        horizontalStack.isLayoutMarginsRelativeArrangement = true
        horizontalStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
       self.setLabelStyles()
    }
}
