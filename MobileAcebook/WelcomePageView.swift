import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("Welcome to Acebook!")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("welcomeText")

                Spacer()

                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")
                
                Spacer()

                NavigationLink(destination: SignupView()) {
                    Text("Sign Up")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("signUpButton")
                
                Spacer()
                
                NavigationLink(destination: LoginView()) {
                                    Text("Log In") // Add login button
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.green) // Change color for login button
                                        .cornerRadius(10)
                                }
                                .accessibilityIdentifier("loginButton")
                Spacer()
            }
            .navigationTitle("Welcome")
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
