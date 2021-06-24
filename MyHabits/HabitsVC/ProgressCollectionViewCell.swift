
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProgressCollectionViewCell"
    
    var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.textColor = .systemGray
        label.font = footnoteSb13
        label.toAutoLayout()
        return label
    }()
    
    var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "50%"
        label.textColor = .systemGray
        label.font = footnoteSb13
        label.toAutoLayout()
        return label
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(progressLabel, percentLabel)
        
        let constraints = [
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            progressLabel.heightAnchor.constraint(equalToConstant: 18),
            
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            habitTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            percentLabel.heightAnchor.constraint(equalToConstant: 18)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
