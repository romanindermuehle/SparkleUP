//
//  TodayView.swift
//
//
//  Created by Roman Indermühle on 15.01.2024.
//

import SwiftUI
import SwiftData
import TipKit

struct TodayView: View {
    @Query(sort: \Day.startedAt) var days: [Day]
    @Environment(\.modelContext) var context
    
    @State var showSparkle: Bool = false
    
    @State private var currentGreeting: String = ""
    
    var ringTip = RingTip()
    
    var splitViewVisibility: NavigationSplitViewVisibility?
    
    var screenWidth: Int? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Int(windowScene.coordinateSpace.bounds.width) - (splitViewVisibility == .detailOnly ? 0: 100)
        }
        return nil
    }
    
    var screenHeight: Int? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Int(windowScene.coordinateSpace.bounds.height) / (splitViewVisibility == .detailOnly ? 0: 3)
        }
        return nil
    }
    
    var body: some View {
        NavigationStack {
            if let day = days.last {
                Form {
                    Section {
                        ProgressRing(day: day, ringSizeHeight: CGFloat((screenHeight ?? 0)), ringSizeWidth: CGFloat(screenWidth ?? 0), ringThickness: 30.0, ringHeight: 30.0, ringWidth: 30.0, fontSize: 58)
                            .padding(.top, 8)
                            .padding(.bottom, 35)
                        
                        TipView(ringTip, arrowEdge: .top)
#if(!os(visionOS))
                            .tipBackground(.lightMagenta.opacity(0.2))
#endif
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Section("Daily tasks") {
                        ForEach(DailyTask.allCases, id: \.rawValue) { dailyTask in
                            NavigationLink(value: dailyTask) {
                                if day.tasksDone.contains(where: { $0 == dailyTask.rawValue }) {
                                    dailyTask.labelDone
                                } else {
                                    dailyTask.labelNotDone
                                }
                            }
                        }
                    }
                }
                .navigationTitle(currentGreeting)
                .onAppear {
                    
                    if day.percentage >= 1.0 && day.sparkleSeen == false {
                        showSparkle.toggle()
                        day.sparkleSeen = true
                    }
                    
                    selectNewGreeting()
                    
                    let daysToInsert = checkDayOver(startedAt: day.startedAt)
                    
                    guard let current = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else {return}
                    
                    let futureDay = [Day(startedAt: current)]
                            
                    
                    createDay(days: futureDay)
                }
                .navigationDestination(for: DailyTask.self) { dailyTask in
                    dailyTask.destination
                }
                .fullScreenCover(isPresented: $showSparkle) {
                    NavigationStack {
                        SparkleRing()
                    }
                }
            }
        }
    }
    
    func selectNewGreeting() {
        Greetings.messages.shuffle()
        currentGreeting = Greetings.messages.randomElement() ?? ""
    }
    
    func checkDayOver(startedAt: Date, current: Date = .now) -> [Day] {
        var days: [Day] = []
        
        let isNotToday = !Calendar.current.isDateInToday(startedAt)
        
        if let dayDifference = calculateDayDifference(fromDate: startedAt, toDate: current) {
            if dayDifference >= 2 {
                for n in 0..<dayDifference {
                    if let daySubtractedDate = subtractDayFromDate(numberOfDays: n, subtractFrom: current) {
                        let insertDay = Day(startedAt: daySubtractedDate)
                        days.append(insertDay)
                    }
                    
                }
            } else if isNotToday {
                let newDay = Day(startedAt: current)
                days.append(newDay)
            }
        }
        
        return days
    }
    
    func calculateDayDifference(fromDate: Date, toDate: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day
    }
    
    func subtractDayFromDate(numberOfDays: Int, subtractFrom: Date) -> Date? {
        Calendar.current.date(byAdding: .day, value: -numberOfDays, to: subtractFrom)
    }
    
    func createDay(days: [Day]) {
        for day in days {
            context.insert(day)
        }
        
    }
}



