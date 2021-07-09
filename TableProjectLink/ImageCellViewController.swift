//
//  ImageCellViewController.swift
//  TableProjectLink
//
//  Created by Никита Ничепорук on 7/6/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import UIKit

class ImageCellViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton: UIBarButtonItem = UIBarButtonItem(title: "share", style: .done, target: self, action: #selector(shareButton))
        navigationItem.rightBarButtonItem = rightButton
        print("hello")
    }
    
    @objc func shareButton() {
        guard let image = imageView.image else {return}
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}
