//
//  Home.swift
//  Malendar (iOS)
//
//  Created by Keum MinSeok on 2022/05/02.
//

import SwiftUI

struct Home: View {
    
    @State var currentDate: Date = Date()
        
    //색상 변경할려면 이거 참고해서 여기에 추가하기
    @State private var bgColor = Color.black
    @State private var addmemobuttonColor = Color.indigo
    @State private var addmemoletterColor = Color.white
    
    // Add Memo Button
    @State var showSheetaddmemo: Bool = false

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 20){
                
                // Custom Date Picker // 색상 변경할려면 이거 참고해서 여기에 추가하기
                CustomDatePicker(currentDate: $currentDate,
                                 bgColor: $bgColor,
                                 addmemobuttonColor: $addmemobuttonColor,
                                 addmemoletterColor: $addmemoletterColor)
            }
            .padding(.vertical)
            .background(bgColor)
        }
        .background(bgColor)
        
    // Safe Area Status Bar
        .overlay(alignment: .top, content: {
            Color.white
                .opacity(0)
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 0)
        })
        
    // Safe Area View
        .safeAreaInset(edge: .bottom) {
            
            HStack{
                
                Button(action: {
                    showSheetaddmemo.toggle()
                }) {
                    Text("Add Memo")
                        .fontWeight(.bold)
                    //색상 변경 요소
                        .foregroundColor(addmemoletterColor)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                    //색상 변경 요소
                        .background(addmemobuttonColor, in: Capsule())
                        .fullScreenCover(isPresented: $showSheetaddmemo, content: {
                            AddMemo(bufferDate: self.currentDate, currentDate: self.$currentDate)
                        })
                }
            }
            .padding(.horizontal)
            .padding(.top,10)
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
