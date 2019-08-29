//
//  DetailVC.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class DetailVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    //properties
    var hit: Hit!
    private var detailImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        updateImage(hit: hit)

        let doubleTap = UITapGestureRecognizer(target: self,
                                               action: #selector(didDoubleTap(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        detailImageView.isUserInteractionEnabled = true
        detailImageView.addGestureRecognizer(doubleTap)
    }
    
    //to Zoom by double click
    @objc private func didDoubleTap(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale > 1.0 {
            scrollView.setZoomScale(1.0, animated: true)
        } else {
            let point = recognizer.location(in: detailImageView)
            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / 2,
                              height: scrollSize.height / 2)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        }
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        detailImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        detailImageView.clipsToBounds = true
        detailImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(detailImageView)
    }
    
    private func updateImage(hit: Hit) {
        
        guard let date = hit.date else { return }
        self.navigationItem.title = getStringFromDate(date)
        
        if let url = URL(string: hit.largeImageURL) {
            let placeholder = UIImage(named: AppImages.Placeholder)
            let options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
            detailImageView.kf.indicatorType = .activity
            detailImageView.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
    }
}

extension DetailVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImageView
    }
}
