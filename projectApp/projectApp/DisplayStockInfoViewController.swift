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
                    JSONDecoder().decode(WebsiteResult.self, from: dataResponse)
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
        var indentString = ""
        indentString.append("\"")
        indentString.append(self.stockNews[0].text!)
        indentString.append("...\"")
//        print(indentString) // string check
        
        news.text = indentString
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
    

    @IBAction func BuyButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let balanceFailure = UIAlertController(title: "Balance insufficient. Please try again", message: nil, preferredStyle: UIAlertController.Style.alert)
        let inputFailure = UIAlertController(title: "Please try again with a valid input number", message: nil, preferredStyle: UIAlertController.Style.alert)
        let Success = UIAlertController(title: "Success!", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        balanceFailure.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in balanceFailure.dismiss(animated: true, completion: nil)
        }))
        inputFailure.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in inputFailure.dismiss(animated: true, completion: nil)
        }))
        Success.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in Success.dismiss(animated: true, completion: nil)
        }))
        
        alertController.addTextField { textField in
            textField.placeholder = "Type in the amount that you'd like to buy"
            textField.keyboardType = .numberPad  // it can only take in numbers now
        }
        
        var amount = 0
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            print("\(String(describing: textField.text))")
            amount = (textField.text! as NSString).integerValue
            //check if it can actually do the buying here
            if amount<0  //bad input
            {
                self.present(inputFailure, animated: true, completion: nil)
            }
            else
            {
                if Double(amount)*self.stockPrice > currUser.balance.doubleValue // can't make the purchase, not enough money
                {
                    self.present(balanceFailure, animated: true, completion: nil)
                }
                else
                {
                    currUser.balance = NSNumber(value: currUser.balance.doubleValue - Double(amount)*self.stockPrice) // making the purchase
                    if currUser.stock[self.stockName] == nil{
                        currUser.stock[self.stockName] = amount
                    }
                    else
                    {
                        currUser.stock[self.stockName] = (currUser.stock[self.stockName] ?? 0) + amount
                    }
                    self.present(Success, animated: true, completion: nil)
                }
            }
            //Update change to database
            db.collection("users").document(currUser.username).updateData([
                "stock": currUser.stock,
                "balance": currUser.balance
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Stock bought")
                }
            }
            currProfilePage.viewDidLoad()
            currProfilePage.stockTableView.reloadData()
        }
        
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func SellButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let stockFailure = UIAlertController(title: "Not possessing enough stock. Try again with a valid amount", message: nil, preferredStyle: UIAlertController.Style.alert)
        let inputFailure = UIAlertController(title: "Please try again with a valid input number", message: nil, preferredStyle: UIAlertController.Style.alert)
        let Success = UIAlertController(title: "Success!", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        stockFailure.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in stockFailure.dismiss(animated: true, completion: nil)
        }))
        inputFailure.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in inputFailure.dismiss(animated: true, completion: nil)
        }))
        Success.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in Success.dismiss(animated: true, completion: nil)
        }))
        
        alertController.addTextField { textField in
            textField.placeholder = "Type in the amount that you'd like to sell"
            textField.keyboardType = .numberPad  // it can only take in numbers now
        }
        
        var amount = 0
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            print("\(String(describing: textField.text))")
            amount = (textField.text! as NSString).integerValue
            //check if it can actually do the buying here
            if amount<0  // bad input
            {
                self.present(inputFailure, animated: true, completion: nil)
            }
            else
            {
                if currUser.stock[self.stockName] == nil{  // not enough stock in currUser
                    self.present(stockFailure, animated: true, completion: nil)
                }
                else
                {
                    if currUser.stock[self.stockName] ?? -1 < amount  // can't make the purchase, not enough stock
                    {
                        self.present(stockFailure, animated: true, completion: nil)
                    }
                    else
                    {
                        currUser.stock[self.stockName] = (currUser.stock[self.stockName] ?? 0) - amount  // what after ?? will never happen, because we ensured that it will never be nill before, it has to be > than amount
                        currUser.balance = NSNumber(value: currUser.balance.doubleValue + Double(amount)*self.stockPrice)
                        if currUser.stock[self.stockName] == 0
                        {
                            currUser.stock.removeValue(forKey: self.stockName)  // remove that stock on hold if it's 0
                        }
                        self.present(Success, animated: true, completion: nil)
                    }
                }
            }
            //Update user stock and balance in database
            db.collection("users").document(currUser.username).updateData([
                "stock": currUser.stock,
                "balance": currUser.balance
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Stock bought")
                }
            }
            currProfilePage.viewDidLoad()
            currProfilePage.stockTableView.reloadData()
        }
        
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
