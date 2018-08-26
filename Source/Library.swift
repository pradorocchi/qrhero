import UIKit
import Photos

class Library:UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    weak var view:QRView!
    private var caching:PHCachingImageManager?
    private var items:PHFetchResult<PHAsset>?
    private var size:CGSize!
    private let request:PHImageRequestOptions
    private static let spacing:CGFloat = 1
    
    init() {
        request = PHImageRequestOptions()
        let flow = UICollectionViewFlowLayout()
        super.init(frame:.zero, collectionViewLayout:flow)
        request.resizeMode = .fast
        request.isSynchronous = false
        request.deliveryMode = .fastFormat
        flow.minimumLineSpacing = Library.spacing
        flow.minimumInteritemSpacing = Library.spacing
        flow.sectionInset = UIEdgeInsets(top:Library.spacing, left:Library.spacing, bottom:20, right:Library.spacing)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        alwaysBounceVertical = true
        delegate = self
        dataSource = self
        register(LibraryCell.self, forCellWithReuseIdentifier:String(describing:LibraryCell.self))
    }
    
    required init?(coder:NSCoder) { return nil }
    deinit { caching?.stopCachingImagesForAllAssets() }
    func collectionView(_:UICollectionView, numberOfItemsInSection:Int) -> Int { return items?.count ?? 0 }
    
    func startLoading() {
        if caching == nil {
            let width = bounds.width + 1
            let itemSize = (width / floor(width / 100)) - 2
            size = CGSize(width:itemSize, height:itemSize)
            (collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size
            checkAuth()
        }
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:LibraryCell = dequeueReusableCell(
            withReuseIdentifier:String(describing:LibraryCell.self), for:index) as! LibraryCell
        if let request = cell.request { caching?.cancelImageRequest(request) }
        cell.request = caching?.requestImage(
            for:items![index.item], targetSize:size, contentMode:.aspectFill, options:request) { (image, _) in
                cell.request = nil
                cell.image.image = image
        }
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) {
        self.isUserInteractionEnabled = false
        caching?.requestImageData(for:items![index.item], options:request) { [weak self] (data, _, _, _) in
            guard
                let data = data,
                let image = UIImage(data:data)
            else { return }
            self?.view.read(image:image)
        }
    }
    
    private func checkAuth() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization() { [weak self] (status) in if status == .authorized { self?.load() } }
        case .authorized: load()
        case .denied, .restricted: break
        }
    }
    
    private func load() {
        caching = PHCachingImageManager()
        DispatchQueue.global(qos:.background).async { [weak self] in
            guard let roll = PHAssetCollection.fetchAssetCollections(with:.smartAlbum, subtype:.smartAlbumUserLibrary,
                                                                     options:nil).firstObject else { return }
            let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending:false)]
            options.predicate = NSPredicate(format:"mediaType = %d", PHAssetMediaType.image.rawValue)
            self?.load(roll:roll, options:options)
        }
    }
    
    private func load(roll:PHAssetCollection, options:PHFetchOptions) {
        items = PHAsset.fetchAssets(in:roll, options:options)
        caching?.startCachingImages(for:items!.objects(at:IndexSet(integersIn:0 ..< items!.count)), targetSize:size,
                                    contentMode:.aspectFill, options:request)
        DispatchQueue.main.async { [weak self] in self?.reloadData() }
    }
}
