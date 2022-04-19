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
    
    //MARK: - PRIVATE FUNCTION
    
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
    }
}
