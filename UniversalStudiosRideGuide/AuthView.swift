import SwiftUI
import Firebase
import FirebaseFirestore

struct AuthView: View {
    
    
    @AppStorage("email") private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var isLoginMode = true

    
    
    // to track signup status
    @State private var showAlert = false
  

    
    // to track login status
    
    @AppStorage("successfulLogin") var successfulLogin = false
    
    
    var body: some View {
        
        
        
        
        let authScreenContent = ZStack {
            ZStack {
                
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.051, green: 0.196, blue: 0.302), // Custom color with RGB values
                            Color(red: 0.498, green: 0.353, blue: 0.514) // Custom color with RGB values
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in
                    VStack(spacing: 20) {
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.6)
                            .padding(.top, 30)
                        
                        VStack(spacing: 15) {
                            TextField("Email", text: $email)
                                .foregroundColor(.white) // Text color when typing
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                                .accentColor(.black)
                                .padding(.horizontal, 20)
                                .font(.headline)
                                .bold()
                                .autocapitalization(.none)
                                .colorScheme(.dark)
                            
                            SecureField("Password", text: $password)
                                .foregroundColor(.white) // Text color when typing
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                                .accentColor(.black)
                                .padding(.horizontal, 20)
                                .font(.headline)
                                .bold()
                                .autocapitalization(.none)
                                .colorScheme(.dark)
                            if !isLoginMode {
                                SecureField("Confirm Password", text: $confirmPassword)
                                    .foregroundColor(.white) // Text color when typing
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(10)
                                    .accentColor(.black)
                                    .padding(.horizontal, 20)
                                    .font(.headline)
                                    .bold()
                                    .autocapitalization(.none)
                                    .colorScheme(.dark)
                            }
                            
                            if let errorMessage = errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.white)
                                    .padding(.top, 5)
                            }
                        }
                        .padding(.vertical, 20)
                        
                        Button(action: {
                            if isLoginMode {
                                login()
                            } else {
                                signUp()
                            }
                        }) {
                            Text(isLoginMode ? "Login" : "Signup")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .padding(.horizontal, 20)
                        }
                        .padding(.vertical, 10)
                        
                        Button(action: {
                            isLoginMode.toggle()
                        }) {
                            Text(isLoginMode ? "Don't have an account? Sign up" : "Already have an account? Log in")
                                .foregroundColor(Color.yellow)
                                .underline()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Verification Sent"),
                      message: Text("An email verification link has been sent to your email address."),
                      dismissButton: .default(Text("OK")))
            }
        }
        
        
        if successfulLogin {
               

            EnterUsernameView(email: email)
         
            }
        
        else {
                 authScreenContent
            }
        
        
        
        
        
    }

    func login() {
        errorMessage = nil
        if (email.isEmpty || password.isEmpty) {
            errorMessage = "Please type in your information"
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                errorMessage = error?.localizedDescription ?? ""
            } else {
                print("Information is correct. Now checking if it's the first time")
                successfulLogin = true;
               
            }
        }
    }



   



    

    func signUp() {
        errorMessage = nil
        if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
            errorMessage = "Please fill in all fields"
            return
        }

        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in
            if let error = error as NSError? {
                errorMessage = error.localizedDescription
            } else {
  
               sendEmailVerification()
                    
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                isLoginMode = true
                            }
            }
        }
    }

    
    func sendEmailVerification() {
            Auth.auth().currentUser?.sendEmailVerification { error in
                if let error = error as NSError? {
                    print("Error sending email verification:", error.localizedDescription)
                } else {
                    print("Email verification sent.")
                    showAlert = true
               
                }
            }
        }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
