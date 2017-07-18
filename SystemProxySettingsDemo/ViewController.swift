//
//  ViewController.swift
//  SystemProxySettingsDemo
//
//  Created by clqiao on 18/07/2017.
//  Copyright © 2017 codinn. All rights reserved.
//

import Cocoa
import SystemConfiguration

class ViewController: NSViewController {

    var authRef: AuthorizationRef?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // initial auth ref
        
        let error = AuthorizationCreate(nil, nil, [], &authRef)
        assert(error == errAuthorizationSuccess)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func socksProxySet(enabled: Bool) {
        
        Swift.print("Socks proxy set: \(enabled)")
        
        // setup policy database db
        CommonAuthorization.shared.setupAuthorizationRights(authRef: self.authRef!)
        
        // copy rights
        let rightName: String = CommonAuthorization.systemProxyAuthRightName
        var authItem = AuthorizationItem(name: (rightName as NSString).utf8String!, valueLength: 0, value:UnsafeMutableRawPointer(bitPattern: 0), flags: 0)
        var authRight: AuthorizationRights = AuthorizationRights(count: 1, items:&authItem)
        
        let copyRightStatus = AuthorizationCopyRights(self.authRef!, &authRight, nil, [.extendRights, .interactionAllowed, .preAuthorize, .partialRights], nil)
        
        Swift.print("AuthorizationCopyRights result: \(copyRightStatus), right name: \(rightName)")
        assert(copyRightStatus == errAuthorizationSuccess)
        
        
        // set system proxy
        let prefRef = SCPreferencesCreateWithAuthorization(kCFAllocatorDefault, "systemProxySet" as CFString, nil, self.authRef)!
        let sets = SCPreferencesGetValue(prefRef, kSCPrefNetworkServices)!
        
        var proxies = [NSObject: AnyObject]()
        
        // proxy enabled set
        if enabled {
            proxies[kCFNetworkProxiesSOCKSEnable] = 1 as NSNumber
            proxies[kCFNetworkProxiesSOCKSProxy] = "127.0.0.1" as AnyObject?
            proxies[kCFNetworkProxiesSOCKSPort] = 8888 as NSNumber
            proxies[kCFNetworkProxiesExcludeSimpleHostnames] = 1 as NSNumber
        } else {
            proxies[kCFNetworkProxiesSOCKSEnable] = 0 as NSNumber
        }
        
        sets.allKeys!.forEach { (key) in
            let dict = sets.object(forKey: key)!
            let hardware = (dict as AnyObject).value(forKeyPath: "Interface.Hardware")
            
            if hardware != nil && ["AirPort","Wi-Fi","Ethernet"].contains(hardware as! String) {
                SCPreferencesPathSetValue(prefRef, "/\(kSCPrefNetworkServices)/\(key)/\(kSCEntNetProxies)" as CFString, proxies as CFDictionary)
            }
        }
        
        // commit to system preferences.
        let commitRet = SCPreferencesCommitChanges(prefRef)
        let applyRet = SCPreferencesApplyChanges(prefRef)
        SCPreferencesSynchronize(prefRef)
        
        Swift.print("after SCPreferencesCommitChanges: commitRet = \(commitRet), applyRet = \(applyRet)")
    }
    
    // MARK: - actions
    @IBAction func enableSocksProxy(_ sender: AnyObject) {
        socksProxySet(enabled: true)
    }
    
    @IBAction func disableSocksProxy(_ sender: AnyObject) {
        socksProxySet(enabled: false)
    }
}
