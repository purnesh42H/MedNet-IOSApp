//
//  AppDelegate.swift
//  MedNet
//
//  Created by Himanshi Bhardwaj on 3/25/17.
//  Copyright © 2017 HPP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //db 
    var dbFilePath: NSString = NSString()
    
    
    // MARK: - FMDB
    
    let DATABASE_RESOURCE_NAME = "MedNetDatabase"
    let DATABASE_RESOURCE_TYPE = "sqlite"
    let DATABASE_FILE_NAME = "MedNetDatabase.sqlite"
    
    func initializeDb() -> Bool {
        let documentFolderPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let dbfile = "/" + DATABASE_FILE_NAME;
        
        self.dbFilePath = ((documentFolderPath as NSString) as String) + dbfile as NSString
        
        /*
        let filemanager = FileManager.default
        if (!filemanager.fileExists(atPath: dbFilePath as String) ) {
            
            let backupDbPath = Bundle.main.path(forResource: DATABASE_RESOURCE_NAME, ofType: DATABASE_RESOURCE_TYPE)
            
            if (backupDbPath == nil) {
                return false
            } else {
                let error: NSError?
                let copySuccessful = filemanager.copyItem(atPath: backupDbPath!, toPath:dbFilePath as String)
                if !copySuccessful {
                    print("copy failed: \(error?.localizedDescription)")
                    return false
                }
                
            }
            
        } */
        return true
        
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        /********************TAB-BAR CONTROLS********************/
        
       // UITabBar.appearance().barTintColor = UIColor(red: 218.0/255.0, green: 231.0/255.0, blue: 222.0/255.0, alpha: 1.0)
        
        /********************NAVIGATION BAR CONTROLS********************/
        
        UINavigationBar.appearance().barTintColor =  UIColor(red: 234.0/255.0, green: 46.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        
        //UIColor(red: 13.0/255.0, green: 100.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
       
        
        // let navbarFont = UIFont(name: "Avenir-Medium", size: 14) ?? UIFont.systemFontOfSize(14)
        //UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        
        //initializing db
        if self.initializeDb() {
            NSLog("Successful db copy")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

