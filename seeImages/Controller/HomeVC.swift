//
//  HomeVC.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import RealmSwift

//private enum State {
//    case loading
//    case populated(List<Image>)
//    case error(Error)
//    case paging(List<Image>, next: Int)
//
//    var currentRecordings: List<Image> {
//        switch self {
//        case .populated(let recordings):
//            return recordings
//        case .paging(let recordings, _):
//            return recordings
//        default:
//            return List<Image>()
//        }
//    }
//}

class HomeVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Properties
    private let serviceResponseAPI = ServiceResponseAPI()
    private var images: Results<Image>!
    private var imageToPass: Image!
//    private var state = State.loading {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = realm.objects(Image.self)
        loadRecordings(1)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: XibNames.HomeImageCell, bundle: nil),
                                forCellWithReuseIdentifier: Identifiers.HomeImageCell)
    }
    
    func loadRecordings(_ page: Int) {
        serviceResponseAPI.getImages(page: page) { (response) in
            print(page)
            print(PageCounter.currentPage)
            guard let response = response else { return }
            StorageManager.saveImages(response)
            self.collectionView.reloadData()
        }
    }
    
//    func update(response: List<Image>) {
//
//        guard let newRecordings = response else { return }
//
//        var recordings = state.currentRecordings
//        recordings.append(objectsIn: newRecordings)
//
//        if response.hasMorePages {
//            state = .paging(recordings, next: response.nextPage)
//        } else {
//            state = .populated(recordings)
//        }
//    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.HomeImageCell, for: indexPath) as? HomeImageCell {
            let recordings = images[indexPath.item]
            cell.setupView(image: recordings)
            
            if PageCounter.hasMorePages, indexPath.item == images.count - 1 {
                loadRecordings(PageCounter.nextPage)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = width / 2 - 16
        let cellHeight = cellWidth + 56
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageToPass = images[indexPath.item]
        performSegue(withIdentifier: Segues.ToDetailImageVC, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToDetailImageVC {
            if let vc = segue.destination as? DetailVC {
                vc.image = imageToPass
            }
        }
    }
}
