//
//  ContentView.swift
//  Happynewyear
//
//  Created by Kokila on 01/01/26.
//

import SwiftUI

struct ContentView: View {
    @State private var bursts: [UUID] = []

    var body: some View {
        ZStack {
            // Tap anywhere → fireworks
            LinearGradient(colors: [.black, .purple.opacity(0.7)],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .onTapGesture {
                    bursts.append(UUID())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                        if !bursts.isEmpty { bursts.removeFirst() }
                    }
                }

            // FULL-SCREEN STACKED TEXT
            VStack(spacing: 8) {
                Text("HAPPY")
                Text("NEW")
                Text("YEAR")
                Text("🎇🎇")
            }
            .font(.system(size: 64, weight: .heavy))
            .foregroundStyle(.yellow)
            .shadow(color: .yellow.opacity(0.9), radius: 20)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .allowsHitTesting(false) // taps go to screen, not text

            // Fireworks layer
            ForEach(bursts, id: \.self) { _ in
                FirecrackerBurst()
            }
        }
    }
}

struct FirecrackerBurst: View {
    @State private var explode = false
    private let colors: [Color] = [.yellow, .orange, .pink, .cyan, .mint, .red, .purple]

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow.opacity(explode ? 0 : 0.9))
                .frame(width: 24, height: 24)
                .shadow(color: .yellow, radius: 30)
                .scaleEffect(explode ? 2.6 : 0.4)
                .animation(.easeOut(duration: 0.35), value: explode)

            ForEach(0..<30) { _ in
                Circle()
                    .fill(colors.randomElement()!)
                    .frame(width: 8, height: 8)
                    .offset(
                        x: explode ? CGFloat.random(in: -220...220) : 0,
                        y: explode ? CGFloat.random(in: -260...140) : 0
                    )
                    .opacity(explode ? 0 : 1)
                    .animation(.easeOut(duration: 1.2), value: explode)
            }
        }
        .onAppear { explode = true }
    }
}

#Preview {
    ContentView()
}
