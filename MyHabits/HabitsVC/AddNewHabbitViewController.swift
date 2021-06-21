
import UIKit

class AddNewHabbitViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = footnoteSb13
        label.toAutoLayout()
        return label
    }()
    
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.textColor = .black
        text.autocapitalizationType = .none
        text.font = bodyR17
        text.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        text.toAutoLayout()
        return text
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = footnoteSb13
        label.toAutoLayout()
        return label
    }()
    
    private let colorImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "main_icon"))
        image.layer.cornerRadius = image.frame.width / 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = footnoteSb13
        label.toAutoLayout()
        return label
    }()
    
    private let timeText: UITextField = {
        let label = UITextField()
        label.text = "Каждый день в "
        label.font = bodyR17
        label.toAutoLayout()
        return label
    }()
    
    private let date: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .time
        
        date.toAutoLayout()
        return date
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNavigationItems() {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "myLightGray")
        navigationController?.navigationBar.tintColor = UIColor(named: "myPurple")
    
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.title = "Создать"
//        navigationController?.navigationBar.backItem?.title = "Отменить"
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "111", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
    }
    
    @objc func saveHabit() {
 
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(nameLabel, nameTextField, colorLabel, colorImage, timeLabel, timeText, date)
        
        scrollView.toAutoLayout()
        containerView.toAutoLayout()
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 46),
            nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -65),
            
            colorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 83),
            colorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -323),
            
            colorImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 108),
            colorImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            colorImage.widthAnchor.constraint(equalToConstant: 30),
            colorImage.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 153),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            timeText.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 178),
            timeText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            timeText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            date.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 178),
            date.leadingAnchor.constraint(equalTo: timeText.trailingAnchor, constant: 7),
            date.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            date.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
