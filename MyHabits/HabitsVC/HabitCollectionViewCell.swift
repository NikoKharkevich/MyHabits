
import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HabitCollectionViewCell"
    
    var habitName: UILabel = {
        let label = UILabel()
        label.text = "Пей воду!"
        label.textColor = .blue
        label.font = headlineSb17
        label.toAutoLayout()
        return label
        
    }()
    
    var habitTime: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в 7:00"
        label.textColor = .systemGray2
        label.font = captionR12
        label.toAutoLayout()
        return label
    }()
    
    var counter: UILabel = {
        let label = UILabel()
        label.text = "Счетчик: 3"
        label.textColor = .systemGray2
        label.font = captionR12
        label.toAutoLayout()
        return label
    }()
    
    private let colorCircle: UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor.cyan
        let image = UIImage(systemName: "checkmark.circle")
        button.setBackgroundImage(image, for: .normal)
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(tapOnLoginButton), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(habitName, habitTime, counter, colorCircle)
        
        let constraints = [
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: baseInset),
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            habitName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            habitName.heightAnchor.constraint(equalToConstant: 22),
            
            habitTime.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 4),
            habitTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            habitTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            habitTime.heightAnchor.constraint(equalToConstant: 16),
            
            counter.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            counter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            counter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -baseInset),
            
            colorCircle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorCircle.widthAnchor.constraint(equalToConstant: 38),
            colorCircle.heightAnchor.constraint(equalToConstant: 38),
            colorCircle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HabitCollectionViewCell {
    private var baseInset: CGFloat { return 20 }

}
