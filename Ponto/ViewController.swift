//
//  ViewController.swift
//  Ponto
//
//  Created by Jimy Suenaga on 25/09/17.
//  Copyright © 2017 Jimysses. All rights reserved.
//

import UIKit

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var actionHistoryTableView: UITableView!
    @IBOutlet var checkinButton:UIButton!
    var actionHistoryList : [CheckinAction] = []
    
    
    @IBOutlet weak var monthWorktime: UILabel!
    @IBOutlet weak var weekWorktime: UILabel!
    @IBOutlet weak var todayWorktime: UILabel!
    @IBOutlet weak var totalWorktime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var short_totalWorktime = String(format: "%.3f",(UserDefaults.standard.double(forKey: "totalWorktime")))
        
        monthWorktime.text = "\(UserDefaults.standard.double(forKey: "monthWorktime")) hs trabalhados este mes"
        weekWorktime.text = "\(UserDefaults.standard.double(forKey: "monthWorktime")) hs trabalhados esta semana"
        todayWorktime.text = "\(UserDefaults.standard.double(forKey: "monthWorktime")) hs trabalhados hoje"
        totalWorktime.text = "\(short_totalWorktime) hs trabalhados no total"
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func check(_ sender: Any) {
        if(UserDefaults.standard.bool(forKey: "isCheckedIn")){
            print("entrando")
            checkinButton.setTitle("Sair", for: .normal)
            UserDefaults.standard.set(false,forKey: "isCheckedIn")
            actionHistoryList.append(CheckinAction(actionStatus:"checkin",actionTimestamp: Date()))
        }
        else {
            print("saindo")
            checkinButton.setTitle("Entrar", for: .normal)
            UserDefaults.standard.set(true,forKey: "isCheckedIn")
            
            let timestamp = Date()
            let hoursSinceLastAction = timestamp.timeIntervalSince((actionHistoryList.last?.actionTimestamp)!)/3600.0
            
            actionHistoryList.append(CheckinAction(actionStatus:"checkout",actionTimestamp: timestamp))
            
            print(hoursSinceLastAction)
            var user_totalWorktime = UserDefaults.standard.double(forKey: "totalWorktime")
            UserDefaults.standard.set(user_totalWorktime + hoursSinceLastAction,forKey: "totalWorktime")
            
            reloadWorktime(hoursSinceLastAction: hoursSinceLastAction)
        }
        
        actionHistoryList = actionHistoryList.sorted{$0.actionTimestamp > $1.actionTimestamp}
        
        DispatchQueue.main.async{
            self.actionHistoryTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "HistoryCell", for: indexPath) as! ActionHIstoryTableViewCell
        let actionForRow = actionHistoryList[indexPath.row]
        
        if(actionHistoryList[indexPath.row].actionStatus == "checkin")  {
            cell.contentView.backgroundColor = UIColor(red:0.0/255.0,green:216.0/255.0,blue:209.0/255.0,alpha:0.8)
        }
        else{
            cell.contentView.backgroundColor = UIColor.init(red:226.0/255.0,green:226.0/255.0,blue:226.0/255.0,alpha:0.8)
        }
        cell.actionTimestamp.text = actionForRow.actionTimestamp.toString(dateFormat: "dd-MM-yyyy HH:mm:ss")
        cell.lastActionLabel.text = actionForRow.actionStatus == "checkin" ? "Entrando" : "Saindo"
        return cell
    }
    
    func reloadWorktime(hoursSinceLastAction: Double)
    {
        var short_totalWorktime = String(format: "%.3f",(UserDefaults.standard.double(forKey: "totalWorktime")))
        
        monthWorktime.text = "\(UserDefaults.standard.double(forKey: "monthWorktime")) hs trabalhados este mes"
        weekWorktime.text = "\(UserDefaults.standard.double(forKey: "monthWorktime")) hs trabalhados esta semana"
        todayWorktime.text = "\(UserDefaults.standard.double(forKey: "monthWorktime")) hs trabalhados hoje"
        totalWorktime.text = "\(short_totalWorktime) hs trabalhados no total"

    }
    
    
}

