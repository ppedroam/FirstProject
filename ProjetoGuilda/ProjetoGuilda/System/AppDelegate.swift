//
//  AppDelegate.swift
//  ProjetoGuilda
//
//  Created by Pedro Menezes on 27/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeController = TabBarController()
       
        
        return true
    }

}

// tratamento de notificacoes

// funcoes nativas de ABRIR, FECHAR, BACKGROUND
