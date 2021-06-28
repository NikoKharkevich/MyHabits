
import UIKit

protocol HabitCollectionViewCellDelegate {
    func someFunc()
}
class HabitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HabitCollectionViewCell"
    
    weak var delegate: HabitCollectionViewCell?
    
    var habit: Habit? {
        didSet {
            habitName.text = habit?.name
            habitName.textColor = habit?.color
            habitTime.text = habit!.dateString
            colorCircle.backgroundColor = habit?.color
            colorCircle.layer.borderColor = habit?.color.cgColor
            counter.text = "Счетчик: \(habit?.trackDates.count ?? 0)"
        }
    }
    
    var habitName: UILabel = {
        let label = UILabel()
        label.font = headlineSb17
        label.toAutoLayout()
        return label
        
    }()
    
    var habitTime: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = captionR12
        label.toAutoLayout()
        return label
    }()
    
    var counter: UILabel = {
        let label = UILabel()

        label.textColor = .systemGray2
        label.font = captionR12
        label.toAutoLayout()
        return label
    }()
    
    private lazy var colorCircle: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(tapOnColor), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    @objc func tapOnColor() {
        guard let habit = habit else { return }
        if colorCircle.backgroundColor == .white {
            let image = UIImage(systemName: "checkmark")
            colorCircle.setImage(image, for: .normal)
            colorCircle.tintColor = .white
            colorCircle.backgroundColor = habit.color
            counter.text = "\(habit.trackDates.count)"
            
            guard habit.isAlreadyTakenToday else { return }
            HabitsStore.shared.track(self.habit!)
            
        } else {
            colorCircle.backgroundColor = .white
        }
    }
     
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
