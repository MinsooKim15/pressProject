//
//  ViewController.swift
//  pressProject
//
//  Created by minsoo kim on 01/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    var serverURL:String = "http://localhost:3000/api"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
    }
    override func viewDidLayoutSubviews() {
    self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK : Data Stuff - Temporary for local test
    var articleCount = 10
    struct Article {
        var articleID : String
        var title : String
        var subTitle : String
        var date : String
        var company : String
        var image : String
        var url : String
        var siteUrl : String
        
    }
//    private func makingDummyData(_ num:Int)->([Article]){
//        var articleList = [Article]()
//        var _ : Int?
////        for _ in 0 ..< num {
//            let article = Article(
//                title: "용기가 공자는 천지는 것이다.",
//                subTitle : "언덕 어머니, 애기 까닭입니다.",
//                date : "오늘",
//                company : "브리프일보",
//                image: "언덕",
//                url: "https://cdn-images-1.medium.com/fit/c/120/120/1*itqJYWWwTxoX625nJPukjA.jpeg",
//                siteUrl: "http://www.daum.net")
//            articleList.append(article)
////        }
//        let article2 = Article(
//            title: "용기가 공자는 천지는 것이다.",
//            subTitle : "언덕 어머니, 애기 까닭입니다.",
//            date : "오늘",
//            company : "네이버",
//            image: "언덕",
//            url: "https://cdn-images-1.medium.com/fit/c/120/120/1*itqJYWWwTxoX625nJPukjA.jpeg",
//            siteUrl: "http://www.naver.com")
//        articleList.append(article2)
//        return articleList
//
//    }
    var articleList:[Article] = []{
        didSet{
            articleTableView.reloadData()
            print("!!@#$%^&*()!@#$%^&*(")
            print(articleList)
        }
    }
    func findDuplicate(is item:[String:String],in list:[Article])-> (Bool){
        var result:Bool
        for compareItem in list{
            if compareItem.articleID == item["articleID"]{
                return true
            }
        }
        return false
    }
    
    func callNodeApi(from serverUrl: String){
        
        let apiUrl = URL(string: serverUrl)
        let session = URLSession.shared
        var request = URLRequest(url:apiUrl!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler:{data, reponse, error in
            guard error == nil else {
                return
            }
            guard let data = data else{
                return
            }
            print("진행 중 ")
            print(data)
            do{
                if let json = try
                    JSONSerialization.jsonObject(with:data, options: .mutableContainers) as? [[String: String]]{
                    for jsonItem in json{
                        if !self.findDuplicate(is: jsonItem, in: self.articleList){
                            let articleItem = Article(
                                articleID: jsonItem["articleID"]!,
                                title: jsonItem["title"]!,
                                subTitle: jsonItem["subTitle"]!,
                                date: jsonItem["date"]!,
                                company: jsonItem["company"]!,
                                image: jsonItem["image"]!,
                                url: jsonItem["url"]!,
                                siteUrl: jsonItem["siteUrl"]!)
                            self.articleList.append(articleItem)
                        }
                    }
                    
                    print(self.articleList)
                }else{
                }
            } catch let error {
            }
        })
        task.resume()
    }
    
    
    
//    //서버 접속 테스트
//    func testNodeApi(){
//
//        let apiUrl = URL(string: "http://localhost:3000/api")
//        let session = URLSession.shared
//        var request = URLRequest(url:apiUrl!)
//        request.httpMethod = "GET"
//        let task = session.dataTask(with: request as URLRequest, completionHandler:{data, reponse, error in
//            guard error == nil else {
//                return
//            }
//            guard let data = data else{
//                return
//            }
//            print("진행 중 ")
//            print(data)
//            do{
//                if let json = try JSONSerialization.jsonObject(with:data, options: .mutableContainers) as? [[String: String]]{
//                    print("왔어 일단은")
//                    print(json)
//                    print("************************************")
//                }else{
//                    print("파싱이 안 되는 것 같아!.!")
//                }
//            } catch let error {
//                print("에러가 되었어 일단은?")
//                print(error.localizedDescription)
//            }
//            print("일단끝?")
//        })
//        task.resume()
//    }
    
    var timeStartDictionary: [Int: String] =
        [00 : "깊은 밤",
         07 : "아침",
         12 : "오후",
         18 : "저녁"]

    
    func timeToString() -> (String){
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MM dd HH mm"
        let dateString = formatter.string(from:now)
        let dateStringList = dateString.split(separator: " ")
        let dayString = dateStringList[1]
        let day = String(Int(String(dayString))!)
        let hourString = dateStringList[2]
        print(hourString)
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        let hour = Int(hourString)!
        var hourResult:String
        switch hour{
            case 0..<7:
                hourResult = "깊은 밤"
        case 7..<12:
            hourResult = "아침"
        case 12..<18:
            hourResult = "오후"
        case 18..<24:
            hourResult = "저녁"
        default :
            hourResult = "오늘 하루"
        }
        let result =  day+"일 "+hourResult
        return result
    }
    override func viewWillAppear(_ animated: Bool) {
        callNodeApi(from: serverURL)
        print("Test Node Api 호출 시작")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view는 로드 되었슴다.")
        articleTableView.delegate = self
        articleTableView.dataSource = self
    }
    
    //MARK : TableView Stuff
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//
//    func currentTimeToString() -> String{
//
//    }
    
    @IBOutlet weak var articleTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articleList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastSectionIndex = tableView.numberOfSections - 1
        // Then grab the number of rows in the last section
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.row == 0 {
            
            let cell = articleTableView.dequeueReusableCell(withIdentifier: "startCell", for:indexPath ) as! StartTableViewCell
            cell.currentTime.text = timeToString()
            print(cell)
            print("Cell Return함수도?")
            return cell
        }else if indexPath.row == lastRowIndex{
            let cell = articleTableView.dequeueReusableCell(withIdentifier: "endCell", for: indexPath) as! LastTableViewCell
            return cell
        }else {
            let cell = articleTableView.dequeueReusableCell(withIdentifier: "shortContentCell", for: indexPath) as! ArticleTableViewCell
            
            let theArticle = articleList[indexPath.row-1]
            
            cell.title.text = theArticle.title
            cell.subtitle.text = theArticle.subTitle
            cell.date.text = theArticle.date
            cell.company.text = theArticle.company
            cell.imageUrl = theArticle.url
            cell.urlString = theArticle.siteUrl
            cell.title.tag = indexPath.row - 1
            //MARK: 세그웨이 버튼 관련
//            cell.tempButtonToArticle.tag = indexPath.row - 1
//            cell.tempButtonToArticle.addTarget(self, action: #selector(HomeViewController.buttonTapped(_:)), for : .touchUpInside)
            return cell
        }
        
    }
    var urlToSegue : String?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        if indexPath!.row != 0 && indexPath!.row != articleList.count + 1 {
            if let currentCell = tableView.cellForRow(at: indexPath!) as? ArticleTableViewCell{
                self.urlToSegue = currentCell.urlString
            }
            
            self.performSegue(withIdentifier: "showArticle", sender: self)
        }
    }
    
    var url: String?
    //MARK:세그웨이 버튼 관련 코드
//    @objc func buttonTapped(_ sender: Any) {
//        self.performSegue(withIdentifier: "showArticle", sender: sender)
//    }
    
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
    
    //MARK: Segueway to the webview
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if (identifier == "showArticle"){
                if let wvc = segue.destination as? WebViewController{
//                    let myIndexPath = self.articleTableView.indexPathForSelectedRow
//                    let row = myIndexPath.row
                    if let button:UIButton = sender as? UIButton{
                        wvc.urlString = articleList[button.tag].url
                    }else if let label :UILabel = sender as? UILabel{
                        wvc.urlString = articleList[label.tag].siteUrl
                    }else if let hvc: HomeViewController = sender as? HomeViewController{
                         wvc.urlString = hvc.urlToSegue
                    }
                }
            }
        }
    }
}

