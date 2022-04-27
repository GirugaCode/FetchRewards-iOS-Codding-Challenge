//
//  DessertCells.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/19/22.
//

import UIKit

class DessertCell: UITableViewCell {
    //MARK: - UI COMPONENTS
    
    /// Back View of each dessert menu cell
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.6509803922, blue: 0.09803921569, alpha: 1)
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .init(width: 0, height: 0)
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Image view of each dessert menu cell
    let dessertImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 2
        iv.layer.borderColor = #colorLiteral(red: 0.9725490196, green: 0.6509803922, blue: 0.09803921569, alpha: 1)
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    /// Title view of each dessert menu cell
    let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Title text of each dessert menu cell
    let titleText: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1843137255, green: 0.04705882353, blue: 0.2196078431, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OVERRIDE FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        configureAutoLayout()
    }
    
    //MARK: - PUBLIC FUNCTIONS
    
    /// Configures cell data to appear for DessertCells view
    func configureCell(dessertItem: Dessert) {
        dessertImageView.loadImageFromURL(urlString: dessertItem.strMealThumb, placeholder: UIImage(named: "FetchRewardsPlaceholder"))
        
        titleText.text = dessertItem.strMeal
    }
    
    //MARK: - PRIVATE FUNCTIONS
    
    /// Configures layout of the Dessert Cell
    private func configureAutoLayout() {
        contentView.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            backView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backView.addSubview(dessertImageView)
        dessertImageView.addSubview(titleView)
        titleView.addSubview(titleText)

        NSLayoutConstraint.activate([
            dessertImageView.topAnchor.constraint(equalTo: backView.topAnchor),
            dessertImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            dessertImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            dessertImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            
            titleView.heightAnchor.constraint(equalTo: dessertImageView.heightAnchor, multiplier: 0.25),
            titleView.leadingAnchor.constraint(equalTo: dessertImageView.leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: dessertImageView.bottomAnchor),
            titleView.trailingAnchor.constraint(equalTo: dessertImageView.trailingAnchor),
            
            titleText.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleText.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 10)
        ])
    }
}
