//
//  AddMemo.swift
//  Malendar (iOS)
//
//  Created by Keum MinSeok on 2022/05/02.
//

import SwiftUI

struct AddMemo: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var listrowaddmemoColor = Color.indigo
    
    var bufferDate: Date
    @Binding var currentDate: Date
    
    @State private var text: String = ""
    @State private var savedText: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("Primary")
                .edgesIgnoringSafeArea(.bottom)
            
            VStack (alignment: .leading) {
                Button(action: {
                    self.currentDate = bufferDate
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.primary)
                        .padding(.top, 9)
                        .padding(.bottom, 1)
                        .padding(.leading, 15)
                }
                List {
                    Section {
                        Group {
                            DatePicker("Date", selection: $currentDate, displayedComponents: [.date])
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                        }
                        .listRowBackground(listrowaddmemoColor)
                        .listRowSeparatorTint(.primary)
                        Group {
                            CustomeTextEditor.init(placeholder: "Start Typing...", text: $text)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(5)
                                .font(.system(size: 16))
                                .onTapGesture {}
                        }
                        .listRowBackground(listrowaddmemoColor)
                    } header: {
                        Text("Take Memo")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("Very Peri"))
                    }
                }
            }
            .onTapGesture { hideKeyboardAndSave() }
            .safeAreaInset(edge: .bottom) {
                
                HStack{
                    
                    Button(action: {
                        //                        currentDate = datePickerSelection
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.indigo, in: Capsule())
                    }
                }
                .padding(.horizontal)
                .padding(.top,10)
                .foregroundColor(.primary)
                .background(.ultraThinMaterial)
            }
        }
    }
    
    private func hideKeyboardAndSave() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        save()
    }
    
    private func save() {
        savedText = text
    }
}

struct CustomeTextEditor: View {
    
    let placeholder: String
    @Binding var text: String
    let internalPadding: CGFloat = 5
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.primary.opacity(0.3))
                    .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
                    .padding(internalPadding)
            }
            TextEditor(text: $text)
                .padding(internalPadding)
        }.onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onAppear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

struct AddMemo_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
