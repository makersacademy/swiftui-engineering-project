import SwiftUI
struct WelcomePageView: View {
    @State private var showLogin = false
    @State private var showSignUp = false
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
                Button("Sign Up") {
                    showSignUp = true
                }
                .sheet(isPresented: $showSignUp) {
                    SignUpView()
                }
                .accessibilityIdentifier("signUpButton")
                Button("Log In") {
                    showLogin = true
                }
                .sheet(isPresented: $showLogin) {
                    LoginView()
                }
                .accessibilityIdentifier("loginButton")
                Spacer()
            }
        }
    }
}
struct WelcomePageView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomePageView()
  }
}
