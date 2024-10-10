//
//  YapilacaklarRepository.swift
//  ToDoApplicationZumrutEdition
//
//  Created by Berke Özgüder on 10.10.2024.
//

import Foundation
import RxSwift

class YapilacaklarRepository {
    var yapilacaklarListesi = BehaviorSubject<[Yapilacaklar]>(value: [Yapilacaklar]())
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yapilacaklar.sqlite")
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func kaydet(yapilacak_name:String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO toDos (yapilacak_name) VALUES (?)", values: [yapilacak_name])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func guncelle(yapilacak_id:Int,yapilacak_name:String){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE toDos SET yapilacak_name = ? WHERE yapilacak_id = ?", values: [yapilacak_name,yapilacak_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func sil(yapilacak_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM toDos WHERE yapilacak_id = ?", values: [yapilacak_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func ara(aramaKelimesi:String){
        db?.open()
        
        do{
            var liste = [Yapilacaklar]()
            
            let rs = try db!.executeQuery("SELECT * FROM toDos WHERE yapilacak_name like '%\(aramaKelimesi)%' ", values: nil)
            
            while rs.next() {
                let yapilacak_id = Int(rs.string(forColumn: "yapilacak_id"))
                let yapilacak_name = rs.string(forColumn: "yapilacak_name")

                
                let yapilacak = Yapilacaklar(yapilacak_id: yapilacak_id!, yapilacak_name: yapilacak_name!)
                liste.append(yapilacak)
            }
            
            yapilacaklarListesi.onNext(liste)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func yapilacaklariYukle(){
        db?.open()
        
        do{
            var liste = [Yapilacaklar]()
            
            let rs = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            
            while rs.next() {
                let yapilacak_id = Int(rs.string(forColumn: "yapilacak_id"))
                let yapilacak_name = rs.string(forColumn: "yapilacak_name")

                
                let yapilacak = Yapilacaklar(yapilacak_id: yapilacak_id!, yapilacak_name: yapilacak_name!)
                liste.append(yapilacak)
            }
            
            yapilacaklarListesi.onNext(liste)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
