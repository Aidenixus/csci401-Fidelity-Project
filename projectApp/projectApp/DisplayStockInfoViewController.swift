//
//  DisplayStockInfoViewController.swift
//  StockSearch
//
//  Created by 罗崴 on 11/7/19.
//  Copyright © 2019 (I) Haiyu Tian. All rights reserved.
//

import UIKit
import Foundation

struct WebsiteResult: Decodable
{
    let data: [StockNews]
}



struct StockNews: Decodable {
    let title: String?
    let news_url: String?
    let image_url: String?
    let text: String?
    let sentiment: String?
    let type: String?
    let source_name: String?
    let date: String?
    let tickers: [String]?
    let topics: [String]?
    init(){
        self.title = ""
        self.news_url = ""
        self.image_url = ""
        self.text = "Stock news not found"
        self.sentiment = ""
        self.type = ""
        self.source_name = ""
        self.date = ""
        self.tickers = []
        self.topics = []
    }
}


struct StockResult: Decodable
{
    var symbol: String?
    var price: double_t?
    
}



class DisplayStockInfoViewController: UIViewController {

    func GetStockInfo(completion: @escaping(String, double_t)->Void ) //Get stock information from API
    {
        var apiStockPrice = 0.0
        var apiStockName = ""
        var searchURL = "https://financialmodelingprep.com/api/v3/stock/real-time-price/" + searchInput
        print(searchURL)
        guard let url = URL(string: searchURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                let stockResult  = try
                    JSONDecoder().decode(StockResult.self, from: dataResponse);
                //print the first element from the websiteResult array
                apiStockPrice = stockResult.price ?? 0.0
                apiStockName = stockResult.symbol ?? "Stock Price Not Found"
                completion(apiStockName, apiStockPrice)
                
             } catch let parsingError {
                print("Error", parsingError)
           }
           
        }
        task.resume()
    }
    
    func GetStockNews(completion: @escaping([StockNews]) ->Void){
        var apiStockNews : [StockNews] = []
        guard let url = URL(string: "https://stocknewsapi.com/api/v1?tickers=" +  searchInput + "&items=5&token=p6jtyjvg9ipxczr5loks0f3kqd4oqvz25bbglo5m") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                let websiteResult  = try
                    JSONDecoder().decode(WebsiteResult.self, from: dataResponse);
                if(websiteResult.data.isEmpty){
                    apiStockNews.append(StockNews())
                }
                else{
                    for news in websiteResult.data{
                        print(news)
                        apiStockNews.append(news)
                    }
                }
                completion(apiStockNews)
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
    }
    


    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var news: UILabel!
    
    @IBOutlet weak var stockNameLabel: UILabel!
    
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    var stockName : String = ""
    var stockPrice : double_t = 0.0
    var stockNews : [StockNews] = []
    var searchInput: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(searchInput)
        GetStockInfo (completion: {apiStockName, apiStockPrice in
            self.stockName = apiStockName
            self.stockPrice = apiStockPrice
        })
        
        while(self.stockName == ""){ //let the program wait until info is retrieved from api
            // Maybe add a waiting animation
        }
        print("stock info done")
        stockNameLabel.text = self.stockName
        stockPriceLabel.text = String(self.stockPrice)
        GetStockNews(completion: {apiStockNews in
            self.stockNews = apiStockNews
        })
        while(self.stockNews.isEmpty){
            //Maybe add a loading animation
        }
        print("stock news done")
        news.text = self.stockNews[0].text
        if self.stockNews[0].image_url != ""{
            let imageURL = self.stockNews[0].image_url
            if let url = URL(string: imageURL!){
                do {
                    let data = try Data(contentsOf: url)
                    self.newsImage.image = UIImage(data:data)
                }catch let err{
                    print("Error : \(err.localizedDescription)")
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
