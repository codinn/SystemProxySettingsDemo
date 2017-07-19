# SystemProxySettingsDemo
macOS proxy settings demo in system network preferences.

# How to set proxy in system network preferences with authorizing once, and need not authentication for ever, even the App relaunched?
# SystemProxySettingsDemo App instruction：
1. In the demo App “SystemProxySettingsDemo”, there are two buttons on main view. one is “Enable System Proxy” for setting the proxy of system network preferences(with host: 127.0.0.1, port: 8888), the other is “Disable System Proxy”. See the following screen snapshot.
    ![](https://raw.githubusercontent.com/codinn/SystemProxySettingsDemo/master/Screen%20Snapshot/mainView.png)

# SystemProxySettingsDemo App codes description:
1. SystemProxySettingsDemo souces codes: https://github.com/codinn/SystemProxySettingsDemo
2. Apple Sample Code reference: https://developer.apple.com/library/content/samplecode/EvenBetterAuthorizationSample/Introduction/Intro.html
3. File “ViewController.swift”: Creating an authorization reference, Requesting Authorization, System Network Preferences Proxy settings. 
    
    Function define：
    // requesting authorization with “AuthorizationCopyRights”
    // set system network preferences proxy with “SCPreferencesCreateWithAuthorization” and “SCPreferencesPathSetValue”
    func socksProxySet(enabled: Bool)

4. File “CommonAuthorization.swift”: Authorization policy database entries setting and getting.

5. File “codinnDemoRightRemove.sh”: clean policy database entries for demo.


# Problem Description:
1. Launch SystemProxySettingsDemo App, then click the “Enable Socks Proxy” button, Authentication dialog appears to require user name and password. After inputing the valid user name and password, the system network preferences proxy will be enabled successfully.
2. Click “Disable Socks Proxy”, there is no dialog appears, and the system network preferences proxy will be disabled successfully.
3. When quit and relaunch the SystemProxySettingsDemo App, then click the “Enable Socks Proxy” button, the authentication dialog appears again (requiring user name and password). I don’t want authentication dialog appears when relaunching the App, since I have authorized the App system proxy settings rights.
4. I save the Authorization Rights to the policy database with “AuthorizationRightSet” (setting policy database rule attribute “timeout” as 0, or 3600, or remove the attribute “timeout”), but it does not work. 
5. I try to use kAuthorizationRuleClassAllow or kAuthorizationRuleAuthenticateAsAdmin as parameter “rightDefinition” in function  “AuthorizationRightSet”, but it does not work either.
6. What can I do to implement that behavior.
