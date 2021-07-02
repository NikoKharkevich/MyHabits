
import UIKit

// Alert to avoid multiple clickcking on checkmark after daily tracking done

protocol TrackingAlert {
    func showAlert()
}

extension HabitsViewController: TrackingAlert {
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "Сегодня привычка уже отмечалась.", preferredStyle: .alert)
        let notedAction = UIAlertAction(title: "ОК", style: .default) { _ in
        }
        alertController.addAction(notedAction)
        present(alertController, animated: true, completion: nil)
    }
}


