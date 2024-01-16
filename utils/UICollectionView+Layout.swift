import UIKit

extension UICollectionView {

    static func CalcGridItemSize(width: CGFloat, columns: Int, gridWidth: CGFloat, itemAspectRatio: CGFloat) -> CGSize {
        let space = width - (gridWidth * CGFloat((columns - 1)) + (gridWidth * 2.0))
        let itemWidth: CGFloat = floor(space / CGFloat(columns))
        let itemHeight = itemWidth * itemAspectRatio
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func setGridLayout(width: CGFloat, columns: Int, gridWidth: CGFloat, itemAspectRatio: CGFloat, extraHeight: CGFloat, headerSize: CGSize) -> CGSize {
        let itemSize: CGSize = UICollectionView.CalcGridItemSize(width: width, columns: columns, gridWidth: gridWidth, itemAspectRatio: itemAspectRatio)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = gridWidth
        layout.minimumLineSpacing = gridWidth
        layout.sectionInset = UIEdgeInsets(top: gridWidth, left: gridWidth, bottom: gridWidth, right: gridWidth)
        layout.itemSize = CGSize.init(width: itemSize.width, height: itemSize.height + extraHeight)
        layout.headerReferenceSize = headerSize
        self.setCollectionViewLayout(layout, animated: false)
        return CGSize(width: itemSize.width, height: itemSize.height)
    }

    func setGridLayout(width: CGFloat, itemHeight: CGFloat, columns: Int, gridWidth: CGFloat, headerSize: CGSize) -> CGSize {
        let space = width - (gridWidth * CGFloat((columns - 1)) + (gridWidth * 2.0))
        let itemWidth: CGFloat = floor(space / CGFloat(columns))
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = gridWidth
        layout.minimumLineSpacing = gridWidth
        layout.sectionInset = UIEdgeInsets(top: gridWidth, left: gridWidth, bottom: gridWidth, right: gridWidth)
        layout.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = headerSize
        self.setCollectionViewLayout(layout, animated: false)
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func setSliderLayout(itemWidth: CGFloat, itemHeight: CGFloat, itemSpacing: CGFloat, margin: CGFloat) -> CGSize {
        let itemWidth: CGFloat = itemWidth
        let itemHeight: CGFloat = itemHeight
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: margin, bottom: 0.0, right: margin)
        layout.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize.zero
        self.setCollectionViewLayout(layout, animated: false)
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func setSlideShowLayout(width: CGFloat, columns: Int, gridWidth: CGFloat, itemAspectRatio: CGFloat, headerSize: CGSize) -> CGSize {
        let itemSize: CGSize = UICollectionView.CalcGridItemSize(width: width, columns: columns, gridWidth: gridWidth, itemAspectRatio: itemAspectRatio)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = gridWidth
        layout.minimumLineSpacing = gridWidth
        layout.sectionInset = UIEdgeInsets(top: gridWidth, left: gridWidth, bottom: gridWidth, right: gridWidth)
        layout.itemSize = CGSize.init(width: itemSize.width, height: itemSize.height)
        layout.headerReferenceSize = headerSize
        self.setCollectionViewLayout(layout, animated: false)
        return CGSize(width: itemSize.width, height: itemSize.height)
    }

}

