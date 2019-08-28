//
//  HomeVC.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

private enum State {
    case loading
    case populated([Image])
    case error(Error)
    case paging([Image], next: Int)
    
    var currentRecordings: [Image] {
        switch self {
        case .populated(let recordings):
            return recordings
        case .paging(let recordings, _):
            return recordings
        default:
            return []
        }
    }
}

class HomeVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Properties
    private let serviceResponseAPI = ServiceResponseAPI()
    private var images: [Image]!
    private var imageToPass: Image!
    private var state = State.loading {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecordings()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: XibNames.HomeImageCell, bundle: nil),
                                forCellWithReuseIdentifier: Identifiers.HomeImageCell)
    }

    func loadRecordings() {
        state = .loading
        loadPage(1)
    }
    
    func loadPage(_ page: Int) {
        serviceResponseAPI.getImages(page: page) { (response) in
            guard let response = response else { return }
            self.update(response: response)
        }
    }
    
    func update(response: RecordingsResult) {
        
        if let error = response.error {
            state = .error(error)
            return
        }
        
        guard let newRecordings = response.recordings else { return }
        
        var recordings = state.currentRecordings
        recordings.append(contentsOf: newRecordings)
        
        if response.hasMorePages {
            state = .paging(recordings, next: response.nextPage)
        } else {
            state = .populated(recordings)
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return state.currentRecordings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.HomeImageCell, for: indexPath) as? HomeImageCell {
            let recordings = state.currentRecordings[indexPath.item]
            cell.setupView(image: recordings)
            
            if case .paging(_, let nextPage) = state, indexPath.item == state.currentRecordings.count - 1 {
                loadPage(nextPage)
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
        imageToPass = state.currentRecordings[indexPath.item]
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
