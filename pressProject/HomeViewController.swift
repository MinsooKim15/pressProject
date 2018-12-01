//
//  ViewController.swift
//  pressProject
//
//  Created by minsoo kim on 01/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    // MARK : Data Stuff - Temporary for local test
    var articleCount = 10
    struct Article {
        var title : String
        var subTitle : String
        var date : String
        var company : String
        var image : String
        var url : String
    }
    private func makingDummyData(_ num:Int)->([Article]){
        var articleList = [Article]()
        var _ : Int?
        for _ in 0 ..< num {
            let article = Article(
                title: "용기가 공자는 천지는 것이다.",
                subTitle : "언덕 어머니, 애기 까닭입니다.",
                date : "오늘",
                company : "브리프일보",
                image: "언덕",
                url: "a.com")
            articleList.append(article)
        }
        return articleList
        
    }
    
    var articleList:[Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        articleList = makingDummyData(articleCount)
        print("view는 로드 되었슴다.")
        articleTableView.delegate = self
        articleTableView.dataSource = self
    }
    
    //MARK : TableView Stuff
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("Row 개수 확인 함수도 실행되었슴다.")
        return articleList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastSectionIndex = tableView.numberOfSections - 1
        // Then grab the number of rows in the last section
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.row == 0 {
            
            let cell = articleTableView.dequeueReusableCell(withIdentifier: "startCell", for:indexPath ) as! StartTableViewCell
            cell.currentTime.text = "안녕!"
            print(cell)
            print("Cell Return함수도?")
            return cell
        }else if indexPath.row == lastRowIndex{
            var cell = articleTableView.dequeueReusableCell(withIdentifier: "endCell", for: indexPath) as! LastTableViewCell
            return cell
        }else {
            let cell = articleTableView.dequeueReusableCell(withIdentifier: "shortContentCell", for: indexPath) as! ArticleTableViewCell
            
            let theArticle = articleList[indexPath.row-1]
            cell.title.text = theArticle.title
            cell.subtitle.text = theArticle.subTitle
            cell.date.text = theArticle.date
            cell.company.text = theArticle.company
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        // Then grab the number of rows in the last section
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.row == 0{
            return 56
        }else if indexPath.row == lastRowIndex{
            return 56
        }else {
            return 136
        }
    }
    @IBOutlet weak var articleTableView: UITableView!{
        didSet{
            print("일단 set은 되어따")
        }
    }
}

