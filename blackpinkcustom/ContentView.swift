//
//  ContentView.swift
//  blackpinkcustom
//
//  Created by Abby on 2022/11/7.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var isplay = false
    @State private var volume:Float = 1
    @State private var scale :Double = 1
    @State private var showmember=false
    @State private var others=false
    @State private var selectsong=0
    @State private var date = Date()
    @State private var ran=0
    @State private var showalert=false
    @State private var alertitle=""
    var songs=["shut down","pink venom","du du du","play with fire","ice cream"]
    let player=AVQueuePlayer()
    var body: some View {
        VStack {
            Form {
                    HStack{
                        Image(systemName: "heart.fill")
                        Text("\(songs[selectsong])")
                            .foregroundColor(.pink)
                            .font(.title)
                        Image(systemName: "heart.fill")
                    }
                    Image(songs[selectsong])
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .scaleEffect(scale)
                    Toggle("play music",isOn: $isplay)
                        .onChange(of: isplay, perform: { value in
                            let url = Bundle.main.url(forResource: songs[selectsong], withExtension: "mp3")!
                            let playerItem = AVPlayerItem(url: url)
                            player.replaceCurrentItem(with: playerItem)
                            if value {
                                player.play()
                            } else {
                                player.pause()
                            }
                        })
                    HStack{
                        Stepper("Volume", value: $volume,in: 0...10)
                            .onChange(of: volume) { newValue in
                                player.volume=volume
                            }
                    }
                    HStack{
                        Text("Scale")
                        Slider(value:$scale,in:0.1...3){
                            
                        }minimumValueLabel: {
                            Image(systemName: "0.square")
                        }maximumValueLabel: {
                            Image(systemName: "3.square")
                        }
                    }
                    DatePicker("When you become a blinks?",selection: $date,in:...Date(),displayedComponents: .date)
                        .accentColor(.pink)
                    Text("Since                  \(date.formatted(date: .long, time: .omitted))")
                    
                    Toggle("Change other songs?",isOn: $others)
                            if others{
                                VStack(alignment:.leading){
                                    Picker(selection: $selectsong) {
                                        ForEach(songs.indices){item in
                                            Text("\(songs[item])")
                                        }
                                    } label: {
                                        Text("songs")
                                    }
                                    .pickerStyle(.segmented)
                                    }
                        }
                    
                    
                    
                    Button(action:{
                        showmember=true
                    }){
                        Text("Your creating world")
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding(.horizontal,70)
                    .sheet(isPresented: $showmember) {
                        members(showmember: $showmember)
                    }
            }
            Button {
                ran=Int.random(in: 0...songs.count-1)
                selectsong=ran
                showalert=true
                alertitle=songs[selectsong]
            } label: {
                Image(systemName: "shuffle")
            }
            .alert(alertitle, isPresented: $showalert, actions: {
                        Button("OK") { }
                    })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
