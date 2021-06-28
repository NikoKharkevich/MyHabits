
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
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .systemGray
        label.font = footnoteSb13
        label.toAutoLayout()
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progressViewStyle = .bar
        bar.trackTintColor = myPurple
        bar.progressTintColor = .orange
        bar.setProgress(0, animated: true)
        bar.progress = HabitsStore.shared.todayProgress
        bar.toAutoLayout()
        return bar
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(progressLabel, percentLabel, progressBar)
        
        let constraints = [
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            progressLabel.heightAnchor.constraint(equalToConstant: 18),
            
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            percentLabel.heightAnchor.constraint(equalToConstant: 18),
            
            progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
