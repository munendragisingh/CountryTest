//
//  Utility.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import Foundation
import UIKit

class Utility {
    
    public static let main = Utility()
    private init() {}
    
    var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return nil 
    }
        return sceneDelegate.window
    }
    
    var isConnected: Bool {
        do{
        if try Reachability().connection == .unavailable {
            return false
        }else{
            return true
        }
        }catch{
            return false
        }
        
    }
    
}
