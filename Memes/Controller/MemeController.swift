//
//  MemeController.swift
//  Memes
//
//  Created by user226298 on 9/6/22.
//

import UIKit
import Alamofire

protocol MemeControllerProtocol: AnyObject{
    
    func success()
    func failure(erro:Error)
    
}

class MemeController {
    
    private var arrayMemes: [MemeObject] = []
    
    
    
    func count() -> Int {
        
            return self.arrayMemes.count
        
        }
        
    func loadCurrenteName(indexPath: IndexPath) -> String{
        
        return self.arrayMemes[indexPath.row].name
        
    }
    
    func getRequestMemes(completionHandler: @escaping (Bool, Error?) -> Void) {
        
        AF.request("https://api.imgflip.com/get_memes").responseJSON { response in
             if response.response?.statusCode == 200{
                 if let data = response.data{
                     do {
                         let memeModel: Meme? = try JSONDecoder().decode(Meme.self, from: data)
                         
                         self.arrayMemes = memeModel?.data.memes ?? []
                         
                         completionHandler(true, nil)
                        
                         
                     }catch{
                         print (error)
                         completionHandler(false, error)
                     }
                     
                 }
                 
             }
         }
     }
    }
    

