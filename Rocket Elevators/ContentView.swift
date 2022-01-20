//
//  ContentView.swift
//  Rocket Elevators
//
//  Created by Kieran  Kenga  on 2022-01-10.
//

import SwiftUI
import UIKit
import Foundation
import Alamofire

struct ContentView: View {
    @State private var emailInput = ""
    @State private var wrongEmail: Float = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("R201")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 3040, height: 250)
                    Text("Welcome, PLease Log In!")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    TextField("Email", text: $emailInput)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongEmail))
                    
                    Button("Login") {
                        }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You are logged in @\(emailInput)"), isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                }
            }.navigationBarHidden(true)
        }
    }

    func authenticateUser(emailInput: String) {
        if url == "true" {
            wrongEmail = 0
        } else {
            wrongEmail = 2
        }
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let email123 = "karl_kieran@yahoo.fr"
        let url = URL(string: "https://rocket-ele.herokuapp.com/api/employees/emailValidation/?email=\(email123)")
        guard url != nil else {
            print("Error please enter a correct email")
        }
        print(url)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
