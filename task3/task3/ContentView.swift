import SwiftUI
import Lottie

struct ContentView: View {
    @State private var isAnimating = false
    @State private var showSecondScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                LottieView(name: "animation", loopMode: .loop)
                    .frame(width: 200, height: 200)
                    .scaleEffect(isAnimating ? 1.2 : 1)
                    .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
                    .onAppear { isAnimating.toggle() }
                
                Image(systemName: "app.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isAnimating)
                
                Button("Go to Next Screen") {
                    withAnimation(.spring()) {
                        showSecondScreen.toggle()
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .fullScreenCover(isPresented: $showSecondScreen) {
                    SecondView()
                }
            }
        }
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var opacity = 0.0
    
    var body: some View {
        VStack {
            Text("Second Screen")
                .font(.largeTitle)
                .opacity(opacity)
                .animation(.easeIn(duration: 1), value: opacity)
                .onAppear { opacity = 1.0 }
            
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
