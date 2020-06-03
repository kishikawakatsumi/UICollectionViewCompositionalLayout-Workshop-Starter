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
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(300))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered

                return section
            case .small:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(86))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(86 * 3))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(60))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderView.kind, alignment: .top)
                sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)

                section.boundarySupplementaryItems = [sectionHeader]

                return section
            case .medium:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(132))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(132 * 2))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(60))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderView.kind, alignment: .top)
                sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)

                section.boundarySupplementaryItems = [sectionHeader]

                return section
            case .large:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.605), heightDimension: .fractionalWidth(0.56))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderView.kind, alignment: .top)
                sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)

                section.boundarySupplementaryItems = [sectionHeader]

                return section
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
