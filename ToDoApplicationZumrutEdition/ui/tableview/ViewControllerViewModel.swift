//
//  ViewControllerViewModel.swift
//  ToDoApplicationZumrutEdition
//
//  Created by Berke Özgüder on 10.10.2024.
//


import Foundation
import RxSwift

class ViewControllerViewModel {
    var krepo = YapilacaklarRepository()
    var yapilacaklarListesi = BehaviorSubject<[Yapilacaklar]>(value: [Yapilacaklar]())
    
    init(){
        veritabaniKopyala()
        yapilacaklariYukle()
        yapilacaklarListesi = krepo.yapilacaklarListesi
    }
    
    func sil(yapilacak_id:Int){
        krepo.sil(yapilacak_id: yapilacak_id)
        yapilacaklariYukle()
    }
    
    func ara(aramaKelimesi:String){
        krepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func yapilacaklariYukle(){
        krepo.yapilacaklariYukle()
    }
    
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "yapilacaklar", ofType: ".sqlite")
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("yapilacaklar.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
    }
}


