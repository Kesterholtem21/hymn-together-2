//
//  OnboardingView.swift
//  CitySight
//
//  Created by Liam Grossman on 11/18/24.
//

import SwiftUI

private struct OnboardingViewDetails: View {
    var color: Color
    var headline: String = ""
    var icon: String
    var subheadline: String = ""
    
    var body: some View {
        ZStack {
            Rectangle().fill(color.gradient)
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 15) {
                    Image(systemName: icon).resizable().aspectRatio(contentMode: .fit).frame(width: 80.0, height: 80.0).foregroundStyle(.white)
                    Text(headline)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text(subheadline)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                }
                Spacer()
                
            }
        }.ignoresSafeArea()
    }
}

struct OnboardingSignup : View {
    @State var name: String = ""
    @State var email: String = ""
    @State var bio: String = ""
    @State var showAlert: Bool = false
    @AppStorage("id") var id: String = ""
    @EnvironmentObject var personVM: PersonViewModel
    @EnvironmentObject var hymnSingVM: HymnSingViewModel
    @EnvironmentObject var peopleVM: PeopleViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()
            Text("Signup").bold().font(.title)
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 5) {
                    Text("Name").bold()
                    Text("*").foregroundStyle(.red).bold()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Name", text: $name).padding(.horizontal)
                }.frame(height: 50.0)
            }
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 5) {
                    Text("Email").bold()
                    Text("*").foregroundStyle(.red).bold()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Email", text: $email).padding(.horizontal)
                }.frame(height: 50.0)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Bio").bold()
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Bio", text: $bio).lineLimit(3).padding(.horizontal)
                }.frame(height: 50.0)
            }
                Button {
                    if (email.isEmpty || name.isEmpty) {
                        showAlert = true
                    } else {
                        let avatar = GravatarService.getAvatar(email: email)
                        Task {
                            let person = await BackendService.postPerson(person: PersonModel(name: name, bio: bio.isEmpty ? nil : bio, email: email, avatar: avatar))
                            await MainActor.run {
                                self.id = person.id
                                personVM.getPerson(id: id)
                                personVM.getHymnSings(id: id)
                                peopleVM.getPeople()
                                hymnSingVM.getHymnSings()
                                hymnSingVM.getUserLocation()
                                dismiss()
                            }
                        }
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0).fill(.blue)
                        Text("Continue").foregroundStyle(.white).padding(.horizontal)
                    }.frame(height: 50.0)
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Complete the required fields"))
                }
            Spacer()
        }.padding(.horizontal)
    }
}

struct OnboardingView : View {
    @State var selectionIndex = 0
    @Environment(\.dismiss) var dismiss // get the instance of the dimiss function

    var body: some View {
        ZStack {
            TabView(selection: $selectionIndex) {
                OnboardingViewDetails(color: Color(.blue).opacity(0.8), headline: "Explore Hymns", icon: "music.note", subheadline: "Listen and get lyrics for a variety of hymns").tag(0)
                OnboardingViewDetails(color: Color(.purple).opacity(0.8), headline: "Explore Popular Hymns", icon: "chart.line.uptrend.xyaxis", subheadline: "Explore Hymns people are saving").tag(1)
                OnboardingViewDetails(color: Color(.red).opacity(0.8), headline: "Explore Hymn Sings", icon: "music.note.house", subheadline: "Sing hymns together with friends and family").tag(2)
                OnboardingViewDetails(color: Color(.orange).opacity(0.8), headline: "Community of People", icon: "person.fill", subheadline: "Find other people who share your interests").tag(3)
                OnboardingSignup().tag(4)
            }.ignoresSafeArea().tabViewStyle(.page(indexDisplayMode: .always))
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(PersonViewModel())
        .environmentObject(HymnSingViewModel())
        .environmentObject(PeopleViewModel())
}
