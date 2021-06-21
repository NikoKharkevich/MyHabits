
import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "myLightGray")
        setupNavigationItems()

    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.backgroundColor = .lightGray
        navigationItem.rightBarButtonItem?.tintColor = .purple
    }
    
    @objc func addTapped() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller = sb.instantiateViewController(identifier: "NewHabit") as! AddNewHabbitViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}
