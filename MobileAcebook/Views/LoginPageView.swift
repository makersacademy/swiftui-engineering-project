import SwiftUI

struct LoginPageView: View {
    @State private var user = User(email: "", username: "", password: "")
    @State private var token: String? = nil
    @State private var errorMessage: String? = nil
    @State private var loggedIn: Bool = false // Track login status
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $user.email)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Password", text: $user.password)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                Button("Login") {
                    Task {
                        let service = AuthenticationService()
                        await service.login(user: user) { result in
                            switch result {
                            case .success(let token):
                                self.token = token
                                self.loggedIn = true // Set login status to true
                                print("TOKEN RECEIVED START")
                                print(token)
                                print("TOKEN RECEIVED END")
                            case .failure(let error):
                                self.errorMessage = error.localizedDescription
                            }
                        }
                    }
                }
                NavigationLink(destination: TestView(), isActive: $loggedIn) {
                    EmptyView()
                }
                .hidden()
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
