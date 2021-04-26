//
//  LoginView.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = UserDefaults.standard.string(forKey: UserKeys.username.rawValue) ?? ""
    
    @Binding var isPresented: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text("Create your Gardener Name")
                .font(.largeTitle)
            TextField("Enter username...", text: $username)
            Spacer()
            Button(action: setUsername) {
                Text("Done")
            }
            
        }.padding()
        
    }
    
    func setUsername() {
        print(username)
        UserDefaults.standard.set(username, forKey: UserKeys.username.rawValue)
        isPresented = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isPresented: .constant(true))
    }
}
