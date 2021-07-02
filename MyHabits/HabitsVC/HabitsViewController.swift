
import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = myLightGray
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myLightGray
        setupNavigationItems()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    
    private func setupNavigationItems() {
        navigationController?.navigationBar.backgroundColor = myLightGray
        navigationController?.navigationBar.tintColor = myPurple
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.title =  "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller = sb.instantiateViewController(identifier: "AddNewNavVC") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        
        self.present(controller, animated: true, completion: nil)
        print(type(of: self), #function)
    }
}

private extension HabitsViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.toAutoLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: UICollectionViewDataSource
extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return HabitsStore.shared.habits.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section != 0 else { return }
        let vc = storyboard?.instantiateViewController(identifier: "HabitDetailsVC") as! HabitDetailsViewController
        vc.habit = (collectionView.cellForItem(at: indexPath) as! HabitCollectionViewCell).habit
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath) as! ProgressCollectionViewCell
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.updateProgress()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as! HabitCollectionViewCell
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.habit = HabitsStore.shared.habits[indexPath.row]
            cell.isChecked = { self.collectionView.reloadData() }
            cell.trackAlertDelegate = self
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: cellWidth, height: 60)
        default:
            return CGSize(width: cellWidth, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return baseInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: baseInset, left: baseInset, bottom: .zero, right: baseInset)
    }
    
}

//MARK: Cell Insets
extension HabitsViewController {
    private var baseInset: CGFloat { return 12 }
    
//    space between cells in row
    private var sectionInset: CGFloat { return 17 }
    
//    method for calculating cell width
    private func widthForCell(with collectionVoew: UICollectionView, cellsInRow: Int) -> CGFloat {
        let totalInset: CGFloat = baseInset * CGFloat(cellsInRow - 1)
        let sideInset: CGFloat = sectionInset * 2
        let cellWidth = (collectionView.frame.width - totalInset - sideInset) / CGFloat(cellsInRow)
        return cellWidth
    }
    
//    setting required number of cells in row here
    private var cellWidth: CGFloat {
        return widthForCell(with: collectionView, cellsInRow: 1)
    }
}


