//
//  ViewController.swift
//  Memes
//
//  Created by user226298 on 9/6/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var memTableView: UITableView!
    var controller: MemeController = MemeController()
    
    var arrayMemes:[MemeObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memTableView.delegate = self
        self.memTableView.dataSource = self
        
        self.controller.getRequestMemes { response, error in
            if response == true {
                
                self.memTableView.reloadData()
        }else{
            print(error)
        }
    }
        
       /* AF.request("https://api.imgflip.com/get_memes").responseJSON { response in
            if response.response?.statusCode == 200{
                if let data = response.data{
                    do {
                        let memeModel: Meme? = try JSONDecoder().decode(Meme.self, from: data)
                        
                        print(memeModel?.data.memes.count)
                        
                        self.arrayMemes = memeModel?.data.memes ?? []
                        self.memTableView.reloadData()
                        
                    }catch{
                        print (error)
                    }
                    
                }
                
            }
        }
    }*/
}
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.controller.loadCurrenteName(indexPath: indexPath)
        
        return cell
    }
}

