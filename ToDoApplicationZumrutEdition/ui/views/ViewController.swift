//
//  ViewController.swift
//  ToDoApplicationZumrutEdition
//
//  Created by Berke Özgüder on 10.10.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yapilacakTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var yapilacaklarListesi = [Yapilacaklar]()
    
    var viewModel = ViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        yapilacakTableView.delegate = self
        yapilacakTableView.dataSource = self
        
        _ = viewModel.yapilacaklarListesi.subscribe(onNext: { liste in
            self.yapilacaklarListesi = liste
            self.yapilacakTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yapilacaklariYukle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let kisi = sender as? Yapilacaklar {
                let gidilecekVC = segue.destination as! DetayViewController
                gidilecekVC.kisi = kisi
            }
        }
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(aramaKelimesi: searchText)
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yapilacaklarListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = yapilacakTableView.dequeueReusableCell(withIdentifier: "yapilacakTableViewCell") as! YapilacakTableViewCell
        
        let yap = yapilacaklarListesi[indexPath.row]
        
        hucre.yapilacakIsim.text = yap.yapilacak_name
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kisi = yapilacaklarListesi[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: kisi)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ contextualAction,view,bool in
            let kisi = self.yapilacaklarListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(kisi.yapilacak_name!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sil(yapilacak_id: kisi.yapilacak_id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
