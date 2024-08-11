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
    @Query(sort: \User.createdAt) var users: [User]
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
            ScrollView(.vertical, showsIndicators: false) {
                if let day = days.last {
                    VStack(alignment: .leading) {
                        VStack(alignment: .center) {
                            ProgressRing(day: day, ringSizeHeight: CGFloat((screenHeight ?? 0)), ringSizeWidth: CGFloat(screenWidth ?? 0), ringThickness: 30.0, ringHeight: 30.0, ringWidth: 30.0, fontSize: 58)
                                .padding(.top, 8)
                                .padding(.bottom, 35)
                            
                            TipView(ringTip, arrowEdge: .top)
                                .padding()
                            
                            
                            GroupBox {
                                VStack(alignment: .leading) {
                                    ForEach(DailyTask.allCases, id: \.rawValue) { dailyTask in
                                        GroupBox {
                                            NavigationLink(value: dailyTask) {
                                                if day.tasksDone.contains(where: { $0 == dailyTask.rawValue }) {
                                                    dailyTask.labelDone
                                                } else {
                                                    dailyTask.labelNotDone
                                                }
                                                Spacer()
                                                
                                                Image(systemName: "chevron.right")
                                            }
                                        }
                                    }
                                }
                            } label: {
                                Text("Your Daily Tasks")
                            }
                            .padding()
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .principal) {
                            HStack {
                                if let profilePhoto = users.first?.image {
                                    Image.init(data: profilePhoto)?
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 34, height: 34)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 34, height: 34)
                                        .foregroundStyle(.accent)
                                }
                                
                                if let user = users.first {
                                    Text("\(currentGreeting), \(user.name)")
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding()
                                } else {
                                    Text(currentGreeting)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding()
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .task {
                        
                        if day.percentage >= 1.0 && day.sparkleSeen == false {
                            showSparkle.toggle()
                            day.sparkleSeen = true
                        }
                        
                        selectNewGreeting()
                        
                        if let newDay = createNewDay(days: days) {
                            context.insert(newDay.day)
                            context.insert(newDay.streak)
                        }
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
    }
    
    func selectNewGreeting() {
        Greetings.messages.shuffle()
        currentGreeting = Greetings.messages.randomElement() ?? ""
    }
    
    func createNewDay(days: [Day]) -> (day: Day, streak: Streak)? {
        if !days.contains(where: { $0.startedAt.formatted(date: .abbreviated, time: .omitted) == Date().formatted(date: .abbreviated, time: .omitted) }) {
            let day = Day.init()
            let streak = Streak(lastUpdated: nil)
            
            return (day, streak)
        }
        
        return nil
    }
}



