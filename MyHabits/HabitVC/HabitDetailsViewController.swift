
import UIKit

class HabitDetailsViewController: UIViewController {
    var habit: Habit? 
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    var isNew: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItems()
    }
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private func setupNavigationItems() {
        let nav = navigationController?.navigationBar
        nav?.backgroundColor = myLightGray
        nav?.tintColor = myPurple
        nav?.prefersLargeTitles = false
        nav?.isHidden = false

        navigationItem.titleView = titleLabel
        titleLabel.text = habit?.name
        titleLabel.textColor = habit?.color
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(tapEditHabit))
    }
    
    @objc func dismiss1() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func  tapEditHabit() {
        let vc = HabitViewController()
        vc.habit = self.habit
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.toAutoLayout()
        tableView.backgroundColor = myLightGray
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailsTableViewCell.self))
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


// MARK: UITableViewDataSource
extension HabitDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self), for: indexPath) as! HabitDetailsTableViewCell
        let i = HabitsStore.shared.dates.count - indexPath.row - 1
        cell.timeLabel.text = HabitsStore.shared.trackDateString(forIndex: i)
        
        let selectedHabit = habit
        let date = HabitsStore.shared.dates[i]
        if HabitsStore.shared.habit(selectedHabit!, isTrackedIn: date) {
            cell.checkImage.image = UIImage(systemName: "checkmark")
            cell.checkImage.tintColor = habit?.color
        } else {
            cell.checkImage.image = nil
        }
        
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension HabitDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46.5
        }
}
