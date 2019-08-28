//
//  ImageCell.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import Kingfisher

class HomeImageCell: UICollectionViewCell {

    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homeWightHeighLbl: UILabel!
    @IBOutlet weak var homeSizeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(image: Image) {
        homeWightHeighLbl.text = "\(image.imageHeight) x \(image.imageWidth)"
        
        guard let size = homeSizeLbl.text else { return }
        //TODO: need fix
        let bytesToMegabytes = ByteCountFormatter.string(fromByteCount: Int64(size)!,
                                                         countStyle: .file)
        homeSizeLbl.text = bytesToMegabytes
        
        if let url = URL(string: image.previewURL) {
            let placeholder = UIImage(named: AppImages.Placeholder)
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            homeImg.kf.indicatorType = .activity
            homeImg.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
    }

}
