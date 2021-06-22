
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
    
    private let colorImage: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "myPurple")
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    var pickerVar: Any?
    @objc fileprivate func pickColor() {
        let picker = UIColorPickerViewController()
        picker.selectedColor = colorImage.backgroundColor!
        self.pickerVar = picker.publisher(for: \.selectedColor)
            .sink { color in
                DispatchQueue.main.async {
                    self.colorImage.backgroundColor = color
                }
            }
        self.present(picker, animated: true, completion: nil)
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = footnoteSb13
        label.toAutoLayout()
        return label
    }()
    
    private let timeText: UITextField = {
        let label = UITextField()
        label.text = "Каждый день в"
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
        self.nameTextField.delegate = self
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
    
    // MARK: Keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

}

extension AddNewHabbitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
}
