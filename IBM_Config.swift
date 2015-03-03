//
//  IBM_Config.swift
//  Bluemix Viewer
//
//  Created by Garrett Rowe on 2/25/15.
//  Copyright (c) 2015 Garrett Rowe. All rights reserved.
//


import Foundation
/**
*  IBM_Config NSObject Class shared between the app and the today's widget Extention, it initializes the
*  Bluemix services
*/
class IBM_Config: NSObject {
    
    var applicationId = ""
    var applicationSecret = ""
    var applicationRoute  = ""
    var hasValidConfiguration = true
    var errorMessage = ""
    
    /**
    initIBM
    
    Void Method that initializes all the services involed in the BlueList App
    */
    func initIBM(){
        
        // Read the applicationId from the bluelist.plist or settings app.
        var configurationPath = NSBundle.mainBundle().pathForResource("bluelist", ofType: "plist")
        var configuration = NSDictionary(contentsOfFile: configurationPath!)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.synchronize()
        
        var applicationId = userDefaults.stringForKey("appID")
        var applicationSecret = userDefaults.stringForKey("appS")
        var applicationRoute = userDefaults.stringForKey("infocloud_url")
        
        if (applicationId == "" || applicationId == nil){
            applicationId = configuration!["applicationId"] as? String
        }
        if (applicationSecret == "" || applicationSecret == nil){
            applicationSecret = configuration!["applicationSecret"] as? String
        }
        if (applicationRoute == "" || applicationRoute == nil){
            applicationRoute = configuration!["applicationRoute"] as? String
        }
  
            IBMBluemix.initializeWithApplicationId(applicationId, andApplicationSecret: applicationSecret, andApplicationRoute: applicationRoute)
            IBMData.initializeService()
            IBMPush.initializeService()
            IBMCloudCode.initializeService()
            IBM_Item.registerSpecialization()
    }
}
