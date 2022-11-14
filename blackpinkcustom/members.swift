//
//  members.swift
//  blackpinkcustom
//
//  Created by Abby on 2022/11/9.
//

import SwiftUI

struct members: View {
    let member=["Jennie","Jisoo","Lisa","Rose"]
    let font=["Amberstone","Littlecandy","Dimetone","Reys Monstera","Aachen Typewriter","Adilla and Rita","Amboera Script"]
    @State private var who=0
    @State private var bgcolor=Color.blue
    @State private var bgcolor2=Color.white
    @State private var name=""
    @FocusState private var nameisfocus:Bool
    @State private var index=0
    @Binding var showmember:Bool
    var body: some View {
        ScrollView {
            VStack{
                Image(member[who])
                    .resizable()
                    .scaledToFit()
                    .background(LinearGradient(gradient: Gradient(colors: [bgcolor, bgcolor2]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
                        .ignoresSafeArea())
                
                Picker(selection: $who) {
                    ForEach(member.indices){item in
                        Text(member[item])
                    }
                } label: {
                    Text("Member")
                }
                DisclosureGroup("Don't like their clothes?"){
                    ColorPicker("color1", selection: $bgcolor)
                        .padding(.horizontal)
                    ColorPicker("color2", selection: $bgcolor2)
                        .padding(.horizontal)
                }.padding(.horizontal)
                DisclosureGroup("Sign your name"){
                    TextField("who's creating", text: $name, prompt: Text("enter your name"))
                        .padding()
                        .focused($nameisfocus)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.yellow,lineWidth: 5)
                        }
                        .padding()
                    Button("Submit"){
                        nameisfocus=false
                    }
                    Picker(selection: $index) {
                        ForEach(font.indices){item in
                            Text("Font \(item)")
                        }
                    } label: {
                        Text("Font style")
                    }
                    .pickerStyle(.wheel)

                }
                .padding()
                Text("Creat by \(name)")
                    .foregroundColor(.brown)
                    .font(.custom(font[index], size: 55))
                
                
                Button(action:{
                    showmember=false
                }){
                    Text("return home")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                }
        }
    }
}

struct members_Previews: PreviewProvider {
    static var previews: some View {
        members(showmember: .constant(true))
    }
}
