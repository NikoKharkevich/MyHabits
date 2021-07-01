
import UIKit

class HabitDetailsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItems()
    }
    
    private func setupNavigationItems() {
        navigationController?.navigationBar.backgroundColor = myLightGray
        navigationController?.navigationBar.tintColor = myPurple
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
    }
    
    @objc func dismiss1() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func editHabit() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller = sb.instantiateViewController(identifier: "EditHabitNavVC") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
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
        navigationItem.title = HabitsStore.shared.habits[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self), for: indexPath) as! HabitDetailsTableViewCell
        let i = HabitsStore.shared.dates.count - indexPath.row - 1
        cell.timeLabel.text = HabitsStore.shared.trackDateString(forIndex: i)
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension HabitDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46.5
        }
}
