//
//  CustomDatePicker.swift
//  Malendar (iOS)
//
//  Created by Keum MinSeok on 2022/05/02.
//

import SwiftUI

struct CustomDatePicker: View {
    
    init(currentDate: Binding<Date>,
         bgColor: Binding<Color>,
         addmemobuttonColor: Binding<Color>,
         addmemoletterColor: Binding<Color>)
    
    {
        self._currentDate = currentDate
        self._bgColor = bgColor
        self._addmemobuttonColor = addmemobuttonColor
        self._addmemoletterColor = addmemoletterColor
        
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State private var memotextlist: Array <String> = []
    
    @Binding var currentDate: Date
    
    // SettingColorPicker Button
    @State var showSheet: Bool = false
    
    // Month update on arrow button clicks
    @State var currentMonth: Int = 0
    
    //색상 변경할려면 여기에 추가하기
    @State private var datecapsuleColor = Color.indigo
    @State private var datecircleColor = Color.indigo
    @State private var memobackgroundColor = Color.indigo
    @State private var yearColor = Color.white
    @State private var monthColor = Color.white
    @State private var chevronColor = Color.indigo
    @State private var settingColor = Color.indigo
    @State private var dayoftheweekColor = Color.white
    @State private var memotitleletterColor = Color.white
    @State private var nomemofoundletterColor = Color.white
    @State private var memocontentletterColor = Color.white
    @State private var dateColor = Color.white
    @State private var datememoColor = Color.indigo
    
    @Binding var bgColor: Color
    @Binding var addmemobuttonColor: Color
    @Binding var addmemoletterColor: Color
    
    //UI Color 색상 저장하기
    @State private var colorData : ColorData = ColorData()
    
    var body: some View {
        
        VStack(spacing: 35){
            
            // Days
            let days: [String] =
            ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            
            HStack(spacing: 20) {
                
                Text(extraDate(currentDate: self.currentDate)[0])
                    .font(.title.bold())
                //색상 변경 요소
                    .foregroundColor(yearColor)
                
                Text(extraDate(currentDate: self.currentDate)[1])
                    .font(.title.bold())
                //색상 변경 요소
                    .foregroundColor(monthColor)
                
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation{
                        self.currentDate = self.moveCurrentMonth(isUp: false)
                    }
                } label: {
                    Image(systemName: "chevron.left")
                    //색상 변경 요소 chevron 통일
                        .foregroundColor(chevronColor)
                        .font(.title2)
                }
                
                Button {
                    withAnimation{
                        self.currentDate =  self.moveCurrentMonth(isUp: true)
                    }
                } label: {
                    Image(systemName: "chevron.right")
                    //색상 변경 요소 chevron 통일
                        .foregroundColor(chevronColor)
                        .font(.title2)
                }
                
                Button(action: {
                    showSheet.toggle()
                }) {
                    Image(systemName: "gearshape.fill")
                    //색상 변경 요소
                        .foregroundColor(settingColor)
                        .font(.title2)
                        .fullScreenCover(isPresented: $showSheet, content: {
                            //색상 변경할려면 이거 참고해서 여기에 추가하기
                            SettingColorPicker(bgColor: $bgColor,
                                               addmemobuttonColor: $addmemobuttonColor,
                                               addmemoletterColor: $addmemoletterColor,
                                               memobackgroundColor: $memobackgroundColor,
                                               datecapsuleColor: $datecapsuleColor,
                                               datecircleColor: $datecircleColor,
                                               yearColor: $yearColor,
                                               monthColor: $monthColor,
                                               chevronColor: $chevronColor,
                                               settingColor: $settingColor,
                                               dayoftheweekColor: $dayoftheweekColor,
                                               memotitleletterColor: $memotitleletterColor,
                                               nomemofoundletterColor: $nomemofoundletterColor,
                                               memocontentletterColor: $memocontentletterColor,
                                               dateColor: $dateColor,
                                               datememoColor: $datememoColor)
                        })
                }
            }
            
            .padding(.horizontal)
            
            // Day View
            
            HStack(spacing: 0){
                ForEach(days,id: \.self){day in
                    
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                    //색상 변경 요소
                        .foregroundColor(dayoftheweekColor)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Dates
            // Lazy Grid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns,spacing: 15) {
                
                ForEach(extractDate(currentDate: self.currentDate)) { value in
                    
                    CardView(value: value)
                        .background(
                            
                            Capsule()
                                .fill(datecapsuleColor)
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack(spacing: 15){
                
                Text("Memo")
                    .font(.title2.bold())
                //색상 변경 요소
                    .foregroundColor(memotitleletterColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical,20)
                
                if let memo = memos.first(where: { memo in
                    return isSameDay(date1: memo.memoDate, date2: currentDate)
                }) {
                    List {
                    ForEach(memo.memo) { memo in
                        Text(memo.title)
                    }
                    .foregroundColor(memocontentletterColor)
                    .listRowBackground(memobackgroundColor)
                    .listRowSeparator(.hidden)
                }
                    .background(bgColor)
                    .frame(height: 200)
                    .cornerRadius(20)
                    } else {
                    
                    Text("No Memo Found")
                    //색상 변경 요소
                        .foregroundColor(nomemofoundletterColor)
                }
            }
            .padding()
            
        }
        .onChange(of: currentMonth) { newValue in
            
            //updating Month...
            currentDate =  getCurrentMonth()
        }
        .onAppear {

            self.bgColor = colorData.loadColor(key: "Background", initColor: self.bgColor)
            self.yearColor = colorData.loadColor(key: "Year", initColor: self.yearColor)
            self.monthColor = colorData.loadColor(key: "Month", initColor: self.monthColor)
            self.chevronColor = colorData.loadColor(key: "Chevron", initColor: self.chevronColor)
            self.settingColor = colorData.loadColor(key: "Setting", initColor: self.settingColor)
            self.dayoftheweekColor = colorData.loadColor(key: "Day of the Week", initColor: self.dayoftheweekColor)
            self.dateColor = colorData.loadColor(key: "Date", initColor: self.dateColor)
            self.datememoColor = colorData.loadColor(key: "Date Memo", initColor: self.datememoColor)
            self.datecapsuleColor = colorData.loadColor(key: "Date Capsule", initColor: self.datecapsuleColor)
            self.datecircleColor = colorData.loadColor(key: "Date Circle", initColor: self.datecircleColor)
            self.addmemobuttonColor = colorData.loadColor(key: "Add Memo Button", initColor: self.addmemobuttonColor)
            self.addmemoletterColor = colorData.loadColor(key: "Add Memo Letter", initColor: self.addmemoletterColor)
            self.memotitleletterColor = colorData.loadColor(key: "Memo Title Letter", initColor: self.memotitleletterColor)
            self.nomemofoundletterColor = colorData.loadColor(key: "No Memo Found Letter", initColor: self.nomemofoundletterColor)
            self.memocontentletterColor = colorData.loadColor(key: "Memo Content Letter", initColor: self.memocontentletterColor)
            self.memobackgroundColor = colorData.loadColor(key: "Memo Background", initColor: self.memobackgroundColor)
            
        }
    }
    
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        
        VStack{
            
            if value.day != -1{
                
                if let memo = memos.first(where: { memo in
                    
                    return isSameDay(date1: memo.memoDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: memo.memoDate, date2: currentDate) ?
                                         //색상 변경 요소 (메모 있는 특별 날짜 글자)
                            .white : datememoColor)
                        .frame(maxWidth: .infinity)
                    
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: memo.memoDate, date2: currentDate) ?
                            .white : datecircleColor)
                        .frame(width: 8, height: 8)
                }
                else{
                    
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ?
                                         //색상 변경 요소 (메모 없는 기본 날짜 글자)
                            .white : dateColor)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    //Checking dates
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year and Month for display
    func extraDate(currentDate: Date)->[String]{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func moveCurrentMonth(isUp: Bool) -> Date{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: (isUp ? 1 : -1), to: self.currentDate)
        else{
            return Date()
        }
        
        return currentMonth
    }
    
    func getCurrentMonth() -> Date{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else{
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate(currentDate: Date) -> [DateValue]{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        let currentMonth = currentDate //getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue
            in
            
            // getting day
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Extending Date to get Current Month Dates
extension Date{
    
    func getAllDates()->[Date]{
        
        let calendar = Calendar.current
        
        // getting start Date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        //getting date
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
