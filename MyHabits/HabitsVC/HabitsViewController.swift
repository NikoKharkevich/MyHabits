
import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "myLightGray")
        setupNavigationItems()

    }
    
    private func setupNavigationItems() {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "myLightGray")
        navigationController?.navigationBar.tintColor = UIColor(named: "myPurple")
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller = sb.instantiateViewController(identifier: "AddNewNavVC") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}
