//
//  SettingColorPicker.swift
//  Malendar (iOS)
//
//  Created by Keum MinSeok on 2022/05/02.
//

import SwiftUI

struct SettingColorPicker: View {
    @Environment(\.presentationMode) var presentationMode
    
    //색상 변경할려면 이거 참고해서 여기에 추가하기
    @Binding var bgColor : Color
    @Binding var addmemobuttonColor: Color
    @Binding var addmemoletterColor: Color
    @Binding var memobackgroundColor : Color
    @Binding var datecapsuleColor : Color
    @Binding var datecircleColor : Color
    @Binding var yearColor : Color
    @Binding var monthColor : Color
    @Binding var chevronColor : Color
    @Binding var settingColor : Color
    @Binding var dayoftheweekColor : Color
    @Binding var memotitleletterColor : Color
    @Binding var nomemofoundletterColor : Color
    @Binding var memocontentletterColor : Color
    @Binding var dateColor : Color
    @Binding var datememoColor : Color
    
    @State private var listrowsettingColor = Color.indigo
    
    //UI Color 색상 저장하기
    @State private var colorData : ColorData = ColorData()
    
    var body: some View {
        ZStack {
            Color("Primary")
                .edgesIgnoringSafeArea(.bottom)
            
            VStack (alignment: .leading) {
                Button(action: {
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
                            ColorPicker("Background", selection: $bgColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Year", selection: $yearColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Month", selection: $monthColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Chevron", selection: $chevronColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Setting", selection: $settingColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Day of the Week", selection: $dayoftheweekColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Date", selection: $dateColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Date Memo", selection: $datememoColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Date Capsule", selection: $datecapsuleColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Date Circle", selection: $datecircleColor, supportsOpacity: true)
                                .padding(.horizontal)
                        }
                        .listRowBackground(listrowsettingColor)
                        .foregroundColor(.primary)
                        .listRowSeparator(.hidden)
                        Group {
                            ColorPicker("Add Memo Button", selection: $addmemobuttonColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Add Memo Letter", selection: $addmemoletterColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Memo Title Letter", selection: $memotitleletterColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("No Memo Found Letter", selection: $nomemofoundletterColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Memo Content Letter", selection: $memocontentletterColor, supportsOpacity: true)
                                .padding(.horizontal)
                            ColorPicker("Memo Background", selection: $memobackgroundColor, supportsOpacity: true)
                                .padding(.horizontal)
                        }
                        .listRowBackground(listrowsettingColor)
                        .foregroundColor(.primary)
                        .listRowSeparator(.hidden)
                    } header: {
                        Text("UI Color")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("Very Peri"))
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                
                HStack{
                    
                    Button(action: {
                        //UI Color 색상 저장하기
                        colorData.saveColor(color: bgColor, key: "Background")
                        colorData.saveColor(color: yearColor, key: "Year")
                        colorData.saveColor(color: monthColor, key: "Month")
                        colorData.saveColor(color: chevronColor, key: "Chevron")
                        colorData.saveColor(color: settingColor, key: "Setting")
                        colorData.saveColor(color: dayoftheweekColor, key: "Day of the Week")
                        colorData.saveColor(color: dateColor, key: "Date")
                        colorData.saveColor(color: datememoColor, key: "Date Memo")
                        colorData.saveColor(color: datecapsuleColor, key: "Date Capsule")
                        colorData.saveColor(color: datecircleColor, key: "Date Circle")
                        colorData.saveColor(color: addmemobuttonColor, key: "Add Memo Button")
                        colorData.saveColor(color: addmemoletterColor, key: "Add Memo Letter")
                        colorData.saveColor(color: memotitleletterColor, key: "Memo Title Letter")
                        colorData.saveColor(color: nomemofoundletterColor, key: "No Memo Found Letter")
                        colorData.saveColor(color: memocontentletterColor, key: "Memo Content Letter")
                        colorData.saveColor(color: memobackgroundColor, key: "Memo Background")
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
}

//UI Color 색상 저장하기
struct ColorData {
    private let userDefaults = UserDefaults.standard
    
    func saveColor(color: Color, key: String) {
        let color = UIColor(color).cgColor
        
        if let components = color.components {
            self.userDefaults.set(components, forKey: key)

        }
    }
    
    func loadColor(key: String, initColor: Color) -> Color {
        guard let array = self.userDefaults.object(forKey: key) as? [CGFloat] else {
            return initColor
        }
        
        let color = Color(.sRGB,
                          red: array[0],
                          green: array[1],
                          blue: array[2],
                          opacity: array[3])
        
        return color
    }
}

struct SettingColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
