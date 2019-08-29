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
            detailImage.kf.setImage(with: url, placeholder: placeholder, options: options) { (_) in
                if self.image.date == nil {
                    StorageManager.saveDowloadingDate(image)
                }
                self.navigationItem.leftBarButtonItem?.title = ""
                self.navigationItem.title = self.formattedDate(image: image)
            }
        }
    }
    
    private func formattedDate(image: Image) -> String {
        guard let currentDateTime = image.date else { return "" }
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        return formatter.string(from: currentDateTime)
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
