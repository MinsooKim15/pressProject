//
//  ArticleTableViewCell.swift
//  pressProject
//
//  Created by minsoo kim on 01/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var imageUrl:String?{
        didSet{
            print("일단 URL을 받았는디..")
            print(imageUrl)
            let pictureURL = URL(string: imageUrl!)!
//            do{
//                let data = try Data(contentsOf:pictureURL)
//                self.thumbnail.image = UIImage(data:data)
//            }
//            catch{
//                print(error)
//            }
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with:pictureURL){(data,response,error) in
                if let e = error{
                    print("Error downloading picture: \(e)")
                }else{
                    if let res = response as? HTTPURLResponse{
                        print("Downloaded picture with response code \(res.statusCode)")
                        if let imageData = data{
                            DispatchQueue.main.sync{
                                self.thumbnail.image = UIImage(data: imageData)
                            }
                            
                        }
                    }
                }
            }
            downloadPicTask.resume()
        }
    }
    //temporary for the segueway test

    
    //MARK: 임시버튼(Cell 터치 추가 후 삭제 예정)
    @IBOutlet weak var tempButtonToArticle: UIButton!
    
    var urlString : String?
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var company: UILabel!
    
    @IBOutlet weak var thumbnail: UIImageView!
    
}

