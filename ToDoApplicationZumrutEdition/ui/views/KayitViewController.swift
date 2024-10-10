//
//  KayitViewController.swift
//  ToDoApplicationZumrutEdition
//
//  Created by Berke Özgüder on 10.10.2024.
//

import UIKit

class KayitViewController: UIViewController {
    @IBOutlet weak var tfAd: UITextField!
    
    var viewModel = KayitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let yapilacak_name = tfAd.text {
            viewModel.kaydet(yapilacak_name: yapilacak_name)
        }
    }
}
