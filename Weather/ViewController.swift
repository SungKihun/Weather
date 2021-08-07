//
//  ViewController.swift
//  Weather
//
//  Created by 성기훈 on 2021/08/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var obsrValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obsrValueLabel.text = ""
    }

    @IBAction func weatherRequest(_ sender: Any) {
        var obsrValue: String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let current_date_string = formatter.string(from: Date())
        print(current_date_string)
        
        formatter.dateFormat = "HH"
        let current_hour_string = formatter.string(from: Date(timeIntervalSinceNow: -60*60))
        print(current_hour_string)
        
        let url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=BD1AlYE%2BBJ%2BkyAGxQh1%2B2WEo9zqU7NTSNTyXUglT1EZY37cWWaWITx%2BS6H4DVJwpHX4UW2NBzupmACQnjLR0Cg%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&base_date=\(current_date_string)&base_time=\(current_hour_string)00&nx=60&ny=127"
        let apiURI: URL! = URL(string: url)
        
        let apidata = try! Data(contentsOf: apiURI)
        
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let response = apiDictionary["response"] as! NSDictionary
            let body = response["body"] as! NSDictionary
            let items = body["items"] as! NSDictionary
            let item = items["item"] as! NSArray
            
            for row in item {
                let r = row as! NSDictionary
                if (r["category"] as! String) == "T1H" {
                    obsrValue = r["obsrValue"] as! String
                    obsrValueLabel.text = obsrValue
                    print("obsrValue: \(obsrValue)")
                }
            }
        } catch {
            NSLog("Parse Error!!")
        }
    }
    
}

