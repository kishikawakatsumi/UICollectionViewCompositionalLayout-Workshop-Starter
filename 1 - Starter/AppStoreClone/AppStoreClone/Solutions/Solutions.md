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


// STEP-2 "Use compositional layout"
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)


// STEP-3 "Today header (single column, estimated height)"
// Add the following code under `case .todayHeader:` in `TodayViewController`

let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(82))
let item = NSCollectionLayoutItem(layoutSize: itemSize)

let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(82))
let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

let section = NSCollectionLayoutSection(group: group)
return section


// STEP-4 "Today app (single column, aspect ratio)"
// Add the following code under `case .todayApp:` in `TodayViewController`

let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
let item = NSCollectionLayoutItem(layoutSize: itemSize)

let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.179))
let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

let section = NSCollectionLayoutSection(group: group)
return section


// STEP-5 "Featured cell (Single row, Orthogonal scrolling)"
// Add the following code under `case .featured:` in `GamesViewController`

let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
let item = NSCollectionLayoutItem(layoutSize: itemSize)

let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(300))
let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

let section = NSCollectionLayoutSection(group: group)
section.orthogonalScrollingBehavior = .groupPagingCentered

return section


// STEP-6 "Small cell (multi-row, Orthogonal scrolling)"
// Add the following code under `case .small:` in `GamesViewController`

let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(86))
let item = NSCollectionLayoutItem(layoutSize: itemSize)

let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(86 * 3))
let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

let section = NSCollectionLayoutSection(group: group)
section.orthogonalScrollingBehavior = .groupPagingCentered

return section


// STEP-7 "Section Header"
// Add the following code before `return section` in `case .small:` clause of `GamesViewController`

let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(60))
let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderView.kind, alignment: .top)
sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)


// STEP-8 (Homework) "Medium cell (multi-row, Orthogonal scrolling)"

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


// STEP-9 (Homework) "Large cell (Single row, Orthogonal scrolling, Group paging)"

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
