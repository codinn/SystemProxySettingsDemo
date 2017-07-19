## Description

A demo for changing system proxy settings.

## Problem

After click “Enable System Proxy”, a dialog for requesting auhorization will be popped up, and subsequent clicks won't popup again, which is fine.

But if we Quit and Relaunch the app, the auhorizating dialog will be popped up again.

How can we authorize once and for all?

## Steps to Reproduce

1. Launch demo app “SystemProxySettingsDemo”
1. Click “Enable System Proxy” button, the auhorizating dialog will be popped up
1. The SOCKS proxy setting in system network preferences will be changed to host: 127.0.0.1, port: 8888
1. Click “Disable System Proxy” button to clear system network preferences proxy
1. Quit the app, and launch it again
1. Click “Enable System Proxy” button, the auhorizating dialog will be popped up, again

    ![](https://raw.githubusercontent.com/codinn/SystemProxySettingsDemo/master/Screen%20Snapshot/mainView.png)

## References

1. GitHub repository: https://github.com/codinn/SystemProxySettingsDemo
2. Apple official sample: https://developer.apple.com/library/content/samplecode/EvenBetterAuthorizationSample/Introduction/Intro.html
3. File “ViewController.swift”: Creating an authorization reference, Requesting Authorization, System Network Preferences Proxy settings. 
    
    Function define：
    `// requesting authorization with “AuthorizationCopyRights”
    // set system network preferences proxy with “SCPreferencesCreateWithAuthorization” and “SCPreferencesPathSetValue”
    func socksProxySet(enabled: Bool)`
4. File “CommonAuthorization.swift”: set / get authorization policy database entries
5. File “codinnDemoRightRemove.sh”: clear policy database entries belongs to demo app


## Other Notes:

1. I've tried storing the Authorization Rights to the policy database with “AuthorizationRightSet” (setting policy database rule attribute “timeout” as 0, or 3600, or remove the attribute “timeout”), but it does not work
1. Also tried using `kAuthorizationRuleClassAllow` or `kAuthorizationRuleAuthenticateAsAdmin` as value for parameter `rightDefinition` of function `AuthorizationRightSet`, but it does not work either
