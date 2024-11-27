//
//  FollowButton.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/26/24.
//

import SwiftUI

struct FollowButton: View {
    @EnvironmentObject var personVM: PersonViewModel
    @EnvironmentObject var peopleVM: PeopleViewModel
    @State var presentAlert: Bool = false
    @State var following = false
    @Binding var followers: Int
    @State var person: PersonModel
    
    var body: some View {
        Button {
            following.toggle()
            if following {
                self.followers += 1
                person.followers += 1
                print(person)
                personVM.person.following.append(person.id)
                Task {
                    await BackendService.putPerson(person: person)
                    await BackendService.putPerson(person: personVM.person)
                    await MainActor.run {
                        peopleVM.getPeople()
                        personVM.getFollowing()
                    }
                }
            } else {
                self.followers -= 1
                person.followers -= 1
                print(person)
                personVM.person.following.removeAll(where: {
                    $0 == person.id
                })
                Task {
                    await BackendService.putPerson(person: person)
                    await BackendService.putPerson(person: personVM.person)
                    await MainActor.run {
                        peopleVM.getPeople()
                        personVM.getFollowing()
                    }
                }
            }
        } label: {
            ZStack {
                Color(.blue)
                HStack(spacing: 5) {
                    Image(systemName: following ? "minus" : "plus").foregroundColor(.white)
                    Text(following ? "Unfollow" : "Follow").foregroundColor(.white).bold()
                }.padding(.horizontal, 8).padding(.vertical, 5)
            }.cornerRadius(.infinity).fixedSize()
        }.alert(following ? "Followed \(person.name)" : "Unfollowed \(person.name)", isPresented: $presentAlert) {
            Button("OK", role: .cancel) {}
        }.onAppear {
            following = personVM.person.following.contains(person.id)
        }
    }
}

#Preview {
    @Previewable @State var followers: Int = 0
    return FollowButton(followers: $followers, person: PersonModel())
        .environmentObject(PersonViewModel())
}
