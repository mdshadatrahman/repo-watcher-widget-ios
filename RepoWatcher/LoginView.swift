//
//  LoginView.swift
//  RepoWatcher
//
//  Created by Shadat Rahman on 2/9/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var accessToken: String?
    
    private let contextProvider = AuthenticationContextProvider()

    
    var body: some View {
        VStack {
            if let token = accessToken {
                Text("Authenticated!. \(token)")
            } else {
                Button("Login with GitHub") {
                    authenticateGithub()
                }
            }
        }
    }


    let callbackURLScheme = "repowatcher"

    func authenticateGithub() {
        loadEnvironmentVariables()
        
        guard let clientID = ProcessInfo.processInfo.environment["GITHUB_CLIENT_ID"] else {
            print("github client id not found")
            return
        }
        let redirectURI = "\(callbackURLScheme)://callback".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let state = UUID().uuidString
        let scope = "repo"
        
        let authURL = URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientID)&redirect_uri=\(redirectURI ?? "")&state=\(state)&scope=\(scope)")
        
        let session = ASWebAuthenticationSession(url: authURL!, callbackURLScheme: redirectURI) { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL else {
                print("❌ Authentication failed: \(error?.localizedDescription ?? "")")
                return
            }
            
            if let code = URLComponents(string: callbackURL.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value {
                exchangeCodeForToken(code: code)
            }
        }
        session.presentationContextProvider = contextProvider
        session.start()
    }
    
    func exchangeCodeForToken(code: String) {
        if let clientID = ProcessInfo.processInfo.environment["GITHUB_CLIENT_ID"],
           let clientSecret = ProcessInfo.processInfo.environment["GITHUB_CLIENT_SECRET"] {
            
            let redirectURI = "\(callbackURLScheme)://callback"
            
            var request = URLRequest(url: URL(string: "https://github.com/login/oauth/access_token")!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let body = "client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)&redirect_uri=\(redirectURI)"
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    // Decode the JSON response
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let token = json["access_token"] as? String {
                        DispatchQueue.main.async {
                            accessToken = token
                            print("accessToken: \(accessToken ?? "")")
                        }
                    } else {
                        print("Token not found in response")
                    }
                } catch {
                    print("Failed to decode JSON response: \(error.localizedDescription)")
                }
            }.resume()
        } else {
            print("Github app cred not found")
        }
    }
    
    func loadEnvironmentVariables() {
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            print(".env file not found")
            return
        }

        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            let lines = content.split(separator: "\n")
            for line in lines {
                let keyValue = line.split(separator: "=", maxSplits: 1)
                guard keyValue.count == 2 else { continue }
                let key = String(keyValue[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                let value = String(keyValue[1]).trimmingCharacters(in: .whitespacesAndNewlines)
                setenv(key, value, 1)
            }
        } catch {
            print("Error loading .env file: \(error)")
        }
    }
}


//#Preview {
//    LoginView()
//}
