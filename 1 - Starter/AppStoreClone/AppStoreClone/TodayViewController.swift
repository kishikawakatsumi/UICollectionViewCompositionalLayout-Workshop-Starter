import UIKit

final class TodayViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    lazy var collectionView: UICollectionView = {
        // STEP-2 "Use compositional layout"
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self

        collectionView.register(TodayHeaderCell.nib, forCellWithReuseIdentifier: TodayHeaderCell.reuseIdentifier)
        collectionView.register(TodayAppCell.nib, forCellWithReuseIdentifier: TodayAppCell.reuseIdentifier)

        return collectionView
    }()

    /*
    // STEP-1 "Create compositional layout (Remove comment out)"
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }

            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[sectionIndex].kind

            switch sectionKind {
            case .todayHeader:
                // STEP-3 "Today header (single column, estimated height)"





                return TutorialHelper.dummyLayoutSection()
            case .todayApp:
                // STEP-4 "Today app (single column, aspect ratio)"





                return TutorialHelper.dummyLayoutSection()
            default:
                return nil
            }
        }
        return layout
    }()
     */

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        configureDataSource()
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self] (collectionView, indexPath, item) in
            guard let self = self else { return nil }

            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            switch sectionKind {
            case .todayHeader:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayHeaderCell.reuseIdentifier, for: indexPath)
                return cell
            case .todayApp:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayAppCell.reuseIdentifier, for: indexPath)
                return cell
            default:
                return nil
            }
        }

        let sections = [
            Section(kind: .todayHeader, items: [Item()]),
            Section(kind: .todayApp, items: [
                Item(),
                Item(),
                Item(),
            ]),
        ]

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension TodayViewController: UICollectionViewDelegate {}
