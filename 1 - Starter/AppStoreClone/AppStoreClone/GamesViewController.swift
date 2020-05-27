import UIKit

final class GamesViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self

        collectionView.register(FeaturedAppCell.nib, forCellWithReuseIdentifier: FeaturedAppCell.reuseIdentifier)
        collectionView.register(SmallAppCell.nib, forCellWithReuseIdentifier: SmallAppCell.reuseIdentifier)
        collectionView.register(MediumAppCell.nib, forCellWithReuseIdentifier: MediumAppCell.reuseIdentifier)
        collectionView.register(LargeAppCell.nib, forCellWithReuseIdentifier: LargeAppCell.reuseIdentifier)
        collectionView.register(SectionHeaderView.nib, forSupplementaryViewOfKind: SectionHeaderView.kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier)

        return collectionView
    }()

    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }

            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[sectionIndex].kind

            switch sectionKind {
            case .featured:
                // STEP-5 "Featured cell (Single row, Orthogonal scrolling)"




                
                return TutorialHelper.dummyLayoutSection()
            case .small:
                // STEP-6 "Small cell (multi-row, Orthogonal scrolling)"




                // STEP-7 "Section Header"




                return TutorialHelper.dummyLayoutSection()
            case .medium:
                // STEP-8 (Homework) "Medium cell (multi-row, Orthogonal scrolling)"





                return TutorialHelper.dummyLayoutSection()
            case .large:
                // STEP-9 (Homework) "Large cell (Single row, Orthogonal scrolling, Group paging)"





                return TutorialHelper.dummyLayoutSection()
            default:
                return nil
            }
        }
        return layout
    }()

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
            case .featured:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedAppCell.reuseIdentifier, for: indexPath)
                return cell
            case .small:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallAppCell.reuseIdentifier, for: indexPath)
                return cell
            case .medium:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediumAppCell.reuseIdentifier, for: indexPath)
                return cell
            case .large:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeAppCell.reuseIdentifier, for: indexPath)
                return cell
            default:
                return nil
            }
        }

        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
            guard let self = self else { return nil }

            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            switch sectionKind {
            case .featured:
                return nil
            default:
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                    for: indexPath)
                return sectionHeader
            }
        }

        let sections = [
            Section(kind: .featured, items: [
                Item(), Item(), Item(), Item(),
            ]),
            Section(kind: .small, items: [
                Item(), Item(), Item(),
                Item(), Item(), Item(),
                Item(), Item(), Item(),
                Item(), Item(), Item(),
                Item(),
            ]),
            Section(kind: .medium, items: [
                Item(), Item(), Item(),
                Item(), Item(), Item(),
                Item(), Item(),
            ]),
            Section(kind: .large, items: [
                Item(), Item(), Item(), Item(),
            ]),
            Section(kind: .small, items: [
                Item(), Item(), Item(),
                Item(), Item(), Item(),
                Item(), Item(),
            ]),
        ]

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension GamesViewController: UICollectionViewDelegate {}
