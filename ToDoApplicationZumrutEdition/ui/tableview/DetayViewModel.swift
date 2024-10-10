//
//  DetayViewModel.swift
//  ToDoApplicationZumrutEdition
//
//  Created by Berke Özgüder on 10.10.2024.
//

import Foundation

class DetayViewModel {
    var krepo = YapilacaklarRepository()
    
    func guncelle(yapilacak_id:Int,yapilacak_name:String){
        krepo.guncelle(yapilacak_id: yapilacak_id, yapilacak_name: yapilacak_name)
    }
}
