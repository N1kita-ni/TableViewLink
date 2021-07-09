//
//  ViewController.swift
//  TableProjectLink
//
//  Created by Никита Ничепорук on 7/6/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var secVC: ImageCellViewController?
    @IBOutlet weak var tableView: UITableView!
    let imageLink: Array<String> = ["https://thumb.tildacdn.com/tild6332-3265-4436-a636-323461643033/-/cover/720x720/center/center/-/format/webp/noroot.png", "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg", "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"]
    var currentSelectedIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        secVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecVC") as? ImageCellViewController
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageLink.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentName = imageLink[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = currentName
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelectedIndex = indexPath.row
        guard let vc = secVC else {return}
        _ = vc.view
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: self.imageLink[indexPath.row]),
                let imageData = try? Data(contentsOf: imageUrl) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    if image == nil {
                        let alert = UIAlertController(title: "Error",
                                                      message: "Picture not found",
                                                      preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK",
                                               style: .default,
                                               handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        vc.imageView.image = image
                        self.navigationController?.show(vc, sender: nil)
                    }
                }
            }
        }
    }
}
