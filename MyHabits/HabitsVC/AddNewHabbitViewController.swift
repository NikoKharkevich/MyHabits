
import UIKit

class AddNewHabbitViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private let habitName: UILabel = {
        let label = UILabel()
        label.text = "Habit Name"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.toAutoLayout()
        return label
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "111", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
    }
    
    @objc func saveHabit() {
 
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(habitName)
        
        scrollView.toAutoLayout()
        containerView.toAutoLayout()
        
        scrollView.backgroundColor = .yellow
        containerView.backgroundColor = .cyan
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            habitName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 21),
            habitName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            habitName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            habitName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
