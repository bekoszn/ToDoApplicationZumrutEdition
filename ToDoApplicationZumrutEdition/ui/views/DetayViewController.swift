//
//  DetayViewController.swift
//  ToDoApplicationZumrutEdition
//
//  Created by Berke Özgüder on 10.10.2024.
//

import UIKit

class DetayViewController: UIViewController {

    @IBOutlet weak var tfChange: UITextField!
    
    var kisi: Yapilacaklar?
    var viewModel = DetayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kisi {
            tfChange.text = k.yapilacak_name

        }
    }

    @IBAction func changeButton(_ sender: Any) {
        if let k = kisi , let yapilacak_name = tfChange.text {
            viewModel.guncelle(yapilacak_id: k.yapilacak_id!, yapilacak_name: yapilacak_name)
        }
    }
}

