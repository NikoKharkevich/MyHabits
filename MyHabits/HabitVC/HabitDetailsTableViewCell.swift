//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Nikola Kharkevich on 24.06.2021.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "HabitDetailsTableViewCell"
    
    override var reuseIdentifier: String? {
        return "HabitDetailsTableViewCell"
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = bodyR17
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Вчера"
        label.toAutoLayout()
        return label
    }()
    
    private let checkImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.toAutoLayout()
        
        return image
        
    }()
    
    private func setupCell() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(checkImage)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupCell()
        
        let cellConstraints = [
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            
            checkImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            checkImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            checkImage.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            checkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            checkImage.heightAnchor.constraint(equalToConstant: 44),
            checkImage.widthAnchor.constraint(equalToConstant: 26)
        ]
        NSLayoutConstraint.activate(cellConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
