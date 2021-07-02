
import UIKit

protocol SaveHabit {
    func saveHabit(habit: String)
}

class HabitViewController: UIViewController {
    
    var habit: Habit? {
        didSet {
            guard let currentHabit = habit else { return }
            nameTextField.text = currentHabit.name
            colorImage.backgroundColor = currentHabit.color
            datePicker.date = currentHabit.date
        }
    }
    
    func checkTitle() {
        if habit != nil {
            navigationItem.title = "Править"
        } else {
            navigationItem.title = "Создать"
            deleteHabit.isHidden = true
        }
    }
    
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
//                    self.timeText2.textColor = color
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
    
    private let timeText1: UILabel = {
        let label = UILabel()
        label.font = bodyR17
        label.text = "Каждый день в: "
        label.toAutoLayout()
        return label
    }()
    
    private let timeText2: UILabel = {
        let label = UILabel()
        label.font = bodyR17
        label.textColor = UIColor(named: "myPurple")
        label.toAutoLayout()
        return label
    }()
    
  @objc func dateToTextField() {
        let time = DateFormatter()
        time.dateStyle = .none
        time.timeStyle = .short
        timeText2.text = time.string(from: datePicker.date)
    }
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(dateToTextField), for: .valueChanged)
        picker.toAutoLayout()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.nameTextField.delegate = self
        setupNavigationItems()
        setupViews()
        showCurrentTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func showCurrentTime() {
        let time = DateFormatter()
        time.dateStyle = .none
        time.timeStyle = .short
        timeText2.text = time.string(from: datePicker.date)
    }
    
    private let deleteHabit: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = bodyR17
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Удалить привычку", for: .normal)
        button.addTarget(self, action: #selector(clickDeleteHabit), for: UIControl.Event.touchDown)
        button.toAutoLayout()
        return button
    }()
    
    @objc func clickDeleteHabit() {
        let alertController = UIAlertController(title: "Удалить привычку",
                                                message: "Вы хотите удалить привычку\n '\(nameTextField.text ?? "")' ?",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Нажали Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [self] _ in
            print("Нажали Удалить")
            print("Было \(HabitsStore.shared.habits.count) привычек")
            guard let habitForRemoval = habit else { return }
            print("Удаляем \(habitForRemoval.name)")
            HabitsStore.shared.habits.removeAll(where: { $0 == habitForRemoval } )
            print("Стало \(HabitsStore.shared.habits.count) привычек")
            self.navigationController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "popToRoot"), object: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupNavigationItems() {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "myLightGray")
        navigationController?.navigationBar.tintColor = UIColor(named: "myPurple")
    
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(dismiss1))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
    }
        
    @objc func saveHabit() {
        if let habitUnderEdit = habit {
            habitUnderEdit.name = nameTextField.text ?? "No name"
            habitUnderEdit.color = colorImage.backgroundColor ?? .white
            habitUnderEdit.date = datePicker.date
        } else {
            let newHabit = Habit(name: nameTextField.text ?? "No name",
                                 date: datePicker.date,
                                 color: colorImage.backgroundColor ?? .blue)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismiss1() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(nameLabel, nameTextField, colorLabel, colorImage, timeLabel, timeText1, timeText2, datePicker, deleteHabit)
        
        scrollView.toAutoLayout()
        containerView.toAutoLayout()
        checkTitle()
        
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
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -65),
            
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
            
            timeText1.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 178),
            timeText1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            timeText2.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 178),
            timeText2.leadingAnchor.constraint(equalTo: timeText1.trailingAnchor),
            timeText2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 198),
            datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            deleteHabit.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 638),
            deleteHabit.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            deleteHabit.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            deleteHabit.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            deleteHabit.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
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

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}
