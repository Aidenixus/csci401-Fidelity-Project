//
//  ViewController.swift
//  StockSearch
//
//  Created by (I) Haiyu Tian on 10/17/19.
//  Copyright © 2019 (I) Haiyu Tian. All rights reserved.
//

//import UIKit
//import Foundation
//
//
//
//class StockInfoViewController: UIViewController {
//
//    @IBOutlet weak var getStockButton: UIButton!
//    @IBOutlet weak var stockInfo: UIButton!
//    var segueStockName: String = ""
//    var segueStockPrice: double_t = 0.0
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var DisplayStockInfo = segue.destination as! DisplayStockInfoViewController
//        DisplayStockInfo.myString = segueStockName
//        DisplayStockInfo.stockPrice = segueStockPrice
//
//    }
//
//    func GetStockInfo(completion: @escaping(String, double_t)->Void ) //Get stock information from API
//    {
//        var stockPrice = 0.0
//        var stockName = ""
//        guard let url = URL(string: "https://financialmodelingprep.com/api/v3/stock/real-time-price /AAPL") else {return}
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//        guard let dataResponse = data,
//                  error == nil else {
//                  print(error?.localizedDescription ?? "Response Error")
//                  return }
//            do{
//                let stockResult  = try
//                    JSONDecoder().decode(StockResult.self, from: dataResponse);
//                //print the first element from the websiteResult array
//                stockPrice = stockResult.price!
//                stockName = stockResult.symbol!
//                completion(stockName, stockPrice)
//
//             } catch let parsingError {
//                print("Error", parsingError)
//           }
//
//        }
//        task.resume()
//    }
//
//
//    @IBAction func didPressedGetStockButton(_ sender: UIButton) {
//        print("Outer", self.segueStockName)
//        performSegue(withIdentifier: "segue" , sender: self)
//    }
//
//    @IBAction func didPressedGetStockNewsButton(_ sender: Any) {
//        guard let url = URL(string: "https://stocknewsapi.com/api/v1?tickers=FB&items=50&token=p6jtyjvg9ipxczr5loks0f3kqd4oqvz25bbglo5m") else {return}
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//        guard let dataResponse = data,
//                  error == nil else {
//                  print(error?.localizedDescription ?? "Response Error")
//                  return }
//            do{
//                let websiteResult  = try
//                    JSONDecoder().decode(WebsiteResult.self, from: dataResponse);
//                //print the first element from the websiteResult array
//                print(websiteResult.data[0])
//
//             } catch let parsingError {
//                print("Error", parsingError)
//           }
//        }
//        task.resume()
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        GetStockInfo (completion: {stockName, stockPrice in
//            self.segueStockName = stockName
//            self.segueStockPrice = stockPrice
//            print("Inner", self.segueStockName)
//        })
//        // Do any additional setup after loading the view.
////        let myStockNews = StockNews(title: "myTitle", newsUrl: "myNews", imageUrl: "myImage", text: "myText", sentiment: "mySentiment", type: "myType", sourceName: "mySource", date: "myDate", tickers: [], topics:[])
////        print(myStockNews)
//
//    }
//
//
//}

