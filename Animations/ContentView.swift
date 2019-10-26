//
//  ContentView.swift
//  Animations
//
//  Created by metalnodeug on 25/10/2019.
//  Copyright © 2019 metalnodeug. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let letters = Array("Hello SwiftUI")

    @State private var animationAmount: CGFloat = 1
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var buttonState = true

    var body: some View {

        ZStack{
            HStack{
                ForEach(0..<letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(self.enabled ? Color.blue : Color.red)
                        .offset(self.dragAmount)
                        .animation(Animation.default.delay(Double(num) / 20))
                }

            }
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                }
            )


            VStack{
                Spacer()
                Button("Tap Me") {
                    self.buttonState.toggle()
                }
                .padding(40)
                .background(buttonState ? Color.red : Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationAmount)
                        .opacity(Double(2 - animationAmount))
                        .animation(
                            Animation.easeOut(duration: 1)
                                .repeatForever(autoreverses: false)
                    )
                )
                    .onAppear {
                        self.animationAmount = 2
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
