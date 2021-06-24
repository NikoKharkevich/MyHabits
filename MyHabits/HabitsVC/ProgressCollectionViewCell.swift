
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProgressCollectionViewCell"
    
    var habitName: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
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
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(habitName, habitTime)
        
        let constraints = [
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            habitName.heightAnchor.constraint(equalToConstant: 22),
            
            habitTime.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 4),
            habitTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            habitTime.heightAnchor.constraint(equalToConstant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
