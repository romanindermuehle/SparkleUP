//
//  TodayView.swift
//
//
//  Created by Roman Indermühle on 15.01.2024.
//

import SwiftUI
import SwiftData
import Charts
import TipKit

struct TodayView: View {
    @Query var users: [User]
    @Query var days: [Day]
    @Environment(\.modelContext) var context
    
    @State var showSparkle: Bool = false
    
    private var ringSizeWidth: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.width - 100.0
        } else {
            return UIScreen.main.bounds.width / 4
        }
    }
    
    private var ringSizeHeight: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.height / 3
        } else {
            return UIScreen.main.bounds.height / 3
        }
    }
    
    var ringTip = RingTip()
    
    var body: some View {
        NavigationStack {
            if let day = days.last {
                Form {
                    Section {
                        ProgressRing(day: day, ringSizeHeight: ringSizeHeight, ringSizeWidth: ringSizeWidth, ringThickness: 30.0, ringHeight: 30.0, ringWidth: 30.0)
                            .padding(.top, 8)
                            .padding(.bottom, 35)
                        Text("\(day.percentage * 100, specifier: "%.0f") of 100%")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.accentColor)
                        
                        TipView(ringTip, arrowEdge: .top)
                            .padding()
                            .tipBackground(Color.accentColor.opacity(0.1))
                        
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
                .navigationTitle("Hello, \(users.first?.name ?? "User")")
                .onAppear {
                    
                    if day.percentage >= 1.0 && day.sparkleSeen != true {
                        showSparkle.toggle()
                        day.sparkleSeen = true
                        print(showSparkle)
                    } else {
                        print(day.percentage)
                        print(day.tasksDone.count)
                    }
                    print("\(day.startedAt)")
                    
                    checkDayOver(startedAt: day.startedAt)
                }
                .navigationDestination(for: DailyTask.self) { dailyTask in
                    dailyTask.destination
                }
                .fullScreenCover(isPresented: $showSparkle) {
                    NavigationStack {
                        SparkleRing(showSparkle: $showSparkle)
                    }
                }
            }
        }
    }
    
    func checkDayOver(startedAt: Date) {
        let currentDate = Date()
        
        let isExpired = startedAt.formatted(date: .abbreviated, time: .omitted) != currentDate.formatted(date: .abbreviated, time: .omitted)
        
        print("currentDate:\(currentDate.formatted(date: .abbreviated, time: .omitted))")
        print("startedAt:\(startedAt.formatted(date: .abbreviated, time: .omitted))")
        
        if isExpired {
            newDay()
            print(days.count)
        } else {
            print("\(isExpired)")
        }
    }
    
    func newDay() {
        context.insert(Day.init())
    }
}



