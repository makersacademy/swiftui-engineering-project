import Foundation
import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmation = ""
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("Sign up")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.19607843137254902, green: 0.2901960784313726, blue: 0.6627450980392157))
                        .multilineTextAlignment(.center)
                    Text("Create your account")
                        .foregroundColor(Color(red: 0.615686274509804, green: 0.6588235294117647, blue: 0.9019607843137255))
                }
                .padding(.bottom, 50)
                
                Section{
                    VStack(alignment: .leading, spacing: 10){
                        Text("Username")
                            .fontWeight(.bold)
                        TextField("", text: $username)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 5.0).fill((Color(red: 0.876, green: 0.891, blue: 0.993))))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(/*@START_MENU_TOKEN@*/Color(red: 0.19607843137254902, green: 0.2901960784313726, blue: 0.6627450980392157)/*@END_MENU_TOKEN@*/, lineWidth: 1))
                            .frame(height: 50)
                            .frame(width: 250)
                        Text("Email")
                            .fontWeight(.bold)
                        TextField("", text: $email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.876, green: 0.891, blue: 0.993)))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(/*@START_MENU_TOKEN@*/Color(red: 0.19607843137254902, green: 0.2901960784313726, blue: 0.6627450980392157)/*@END_MENU_TOKEN@*/, lineWidth: 1))
                            .frame(height: 50)
                            .frame(width: 250)
                        Text("Password")
                            .fontWeight(.bold)
                        SecureField("", text: $password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.876, green: 0.891, blue: 0.993)))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(/*@START_MENU_TOKEN@*/Color(red: 0.19607843137254902, green: 0.2901960784313726, blue: 0.6627450980392157)/*@END_MENU_TOKEN@*/,
                                                                                                     lineWidth: 1))
                            .frame(height: 50)
                            .frame(width: 250)
                        Text("Confirm password")
                            .fontWeight(.bold)
                        SecureField("", text: $passwordConfirmation)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.876, green: 0.891, blue: 0.993)))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(/*@START_MENU_TOKEN@*/Color(red: 0.19607843137254902, green: 0.2901960784313726, blue: 0.6627450980392157)/*@END_MENU_TOKEN@*/,
                                                                                                     lineWidth: 1))
                            .frame(height: 50)
                            .frame(width: 250)
                            
                    }
                    .padding()
                        HStack {
                            Section {
                                Button(action: submit){
                                    Text("Submit")
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.615686274509804, green: 0.6588235294117647, blue: 0.9019607843137255)/*@END_MENU_TOKEN@*/)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(/*@START_MENU_TOKEN@*/Color(red: 0.19607843137254902, green: 0.2901960784313726, blue: 0.6627450980392157)/*@END_MENU_TOKEN@*/,
                                                                                                         lineWidth: 3))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .frame(width: 120)
                                .padding(.bottom, 70)
                        }
                    }
                    
                    .scrollContentBackground(/*@START_MENU_TOKEN@*/.hidden/*@END_MENU_TOKEN@*/)
                }
                
                Section{
                    HStack{
                        Text("Already have an account?")
                        NavigationLink(destination: LogInView()) {
                            Text("Log in")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
    }
}




func submit() {
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
