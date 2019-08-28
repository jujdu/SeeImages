//
//  DetailVC.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    //properties
    var image: Image!
    var detailImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        updateImage(image: image)
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.flashScrollIndicators()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        detailImage.frame = CGRect(x: 0, y: 0, width: width, height: height)
        detailImage.clipsToBounds = true
        detailImage.contentMode = .scaleAspectFit
        scrollView.addSubview(detailImage)
    }
    
    func updateImage(image: Image) {
        if let url = URL(string: image.largeImageURL) {
            let placeholder = UIImage(named: AppImages.Placeholder)
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            detailImage.kf.indicatorType = .activity
            //TODO: need to fix with realm
            detailImage.kf.setImage(with: url, placeholder: placeholder, options: options) { (result) in
                if self.image.date == nil {
                    let currentDateTime = Date()
                    let formatter = DateFormatter()
                    formatter.timeStyle = .medium
                    formatter.dateStyle = .long
                    self.image.date = formatter.string(from: currentDateTime)
                }
                
                self.navigationItem.leftBarButtonItem?.title = ""
                self.navigationItem.title = self.image.date
            }
        }
    }
}

extension DetailVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImage
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.zoomScale = 1.0
    }
}
