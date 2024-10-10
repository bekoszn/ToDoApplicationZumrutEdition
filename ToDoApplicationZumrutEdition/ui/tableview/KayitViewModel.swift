//
//  KayitViewModel.swift
//  ToDoApplicationZumrutEdition
//
//  Created by Berke Özgüder on 10.10.2024.
//

import Foundation

class KayitViewModel {
    var krepo = YapilacaklarRepository()
    
    func kaydet(yapilacak_name:String){
        krepo.kaydet(yapilacak_name: yapilacak_name)
    }
}


