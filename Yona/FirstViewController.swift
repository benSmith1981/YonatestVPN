//
//  FirstViewController.swift
//  Yona
//
//  Created by Ben Smith on 08/03/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//

import UIKit
import NetworkExtension
import AlamofireJsonToObjects
import Alamofire

class FirstViewController: UIViewController, UITableViewDelegate {
    
    var manager:NEVPNManager!
    var matchComment: String = "https://feeds.tribehive.co.uk/DigitalStadiumServer/opta?pageType=matchCommentary&value=803294&v=2"
    var matchStats: String = "https://feeds.tribehive.co.uk/DigitalStadiumServer/opta?pageType=match&value=803294&v=2"
    var arrCommentary:NSMutableArray? //Array of dictionary

    @IBOutlet var tblJSON: UITableView!
    @IBOutlet var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.manager = NEVPNManager.sharedManager()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "vpnConnectionStatusChanged",
            name: NEVPNStatusDidChangeNotification,
            object: self)
        


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func vpnConnectionStatusChanged(notification: NSNotification){
        //Take Action on Notification
        let alertView = UIAlertController(title: "VPN Change", message: "\(notification.description)" , preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    @IBAction func startVPN(sender: AnyObject) {
        self.manager!.loadFromPreferencesWithCompletionHandler { (NSError) -> Void in
            let newIPSec = NEVPNProtocolIKEv2()
            let password = "pw";
            newIPSec.username = "test"
            newIPSec.passwordReference = password.dataUsingEncoding(NSUTF8StringEncoding)
            newIPSec.serverAddress = "proxy.yona.nu"
            newIPSec.disconnectOnSleep = false
            newIPSec.useExtendedAuthentication = true
            newIPSec.authenticationMethod = NEVPNIKEAuthenticationMethod.SharedSecret
            let connectRule = NEOnDemandRuleConnect()
            connectRule.interfaceTypeMatch = .Any
            
            self.manager.onDemandRules = [connectRule]
            self.manager.`protocolConfiguration` = newIPSec
            self.manager.enabled = true
            self.manager.saveToPreferencesWithCompletionHandler({ (error) -> Void in
                print(error)
            })
            let url = NSURLRequest(URL: NSURL(string: "https://www.google.com")!)
            self.webView.loadRequest(url)
        }
        
    }
    
    @IBAction func downloadParseJSON(sender: AnyObject) {

        Alamofire.request(.GET, matchComment,parameters:["pageType": "matchCommentary", "value": "803294&v=2"]).responseArray
            {(request: NSURLRequest?,
            HTTPURLResponse: NSHTTPURLResponse?,
            response: Result<[Commentary], NSError>) -> Void in
            
            if let result = response.value {
                self.arrCommentary = 
            }
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("commentCell")!
        let comment:Commentary = arrCommentary!.objectAtIndex(indexPath.row) as! Commentary
        cell.textLabel?.text = comment.heading
        cell.detailTextLabel?.text = comment.commentDescription
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCommentary!.count
    }
}
