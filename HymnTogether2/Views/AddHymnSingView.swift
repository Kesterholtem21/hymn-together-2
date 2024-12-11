//
//  AddHymnSingView.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import SwiftUI
import MapKit
import LocationPicker

struct AddHymnSingView: View {
    @State var name = ""
    @State var lead = ""
    @State var description = ""
    @State var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @State var showSheet = false
    @State var date: Date = Date()
    @State var alert = (false, "")
    @EnvironmentObject var hymnSingVM: HymnSingViewModel
    @EnvironmentObject var personVM: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 5) {
                    Text("Name").bold()
                    Text("*").bold().foregroundStyle(.red)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Name", text: $name).padding(.horizontal)
                }.frame(height: 50.0)
            }
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 5) {
                    Text("Description").bold()
                    Text("*").bold().foregroundStyle(.red)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Description", text: $description).padding(.horizontal).lineLimit(3)
                }.frame(height: 50.0)
            }
            VStack(alignment: .leading, spacing: 10) {
                DatePicker("Date", selection: $date, in: Date()..., displayedComponents: .date).bold()
            }
            Button{
                showSheet = true
            }label: {
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0).fill(.green)
                        Text("Pick a location").foregroundStyle(.white).padding(.horizontal)
                    }.frame(height: 50.0)
                    if location.latitude != 0.0 && location.longitude != 0.0{
                        Text("Latitude: \(location.latitude), Longitude: \(location.longitude)").foregroundStyle(.black)
                    }
                }
            }.sheet(isPresented: $showSheet){
                LocationPicker(instructions: "Pick a location", coordinates: $location)
            }
            Button {
                if name.isEmpty || description.isEmpty {
                    alert.0 = true
                    alert.1 = "Complete required fields"
                } else {
                    let hymnSing = HymnSingModel(
                        personId: personVM.person.id,
                        name: name,
                        description: description,
                        longitude: location.longitude,
                        latitude: location.latitude,
                        date: date.timeIntervalSince1970,
                        person: PersonMetaModel(
                            name: personVM.person.name,
                            avatar: personVM.person.avatar
                        )
                    )
                    Task {
                          let createdHymnSing = await hymnSingVM.postHymnSing(hymnSing: hymnSing)
                          await MainActor.run {
                              personVM.mutateHymnSings(hymnSing:    createdHymnSing)
                          }
                    }
                    reset()
                    alert.1 = "Hymn sing added"
                    alert.0 = true
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.blue)
                    Text("Add Hymn Sing").foregroundStyle(.white).padding(.horizontal)
                }.frame(height: 50.0)
            }.alert(isPresented: $alert.0) {
                Alert(title: Text(alert.1))
            }
            Spacer()
        }.navigationTitle("Add Hymn Sing").padding(.horizontal)
    }
    
    private func reset() {
        self.name = ""
        self.description = ""
        self.date = Date()
        self.location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
}

#Preview {
    AddHymnSingView().environmentObject(HymnSingViewModel()).environmentObject(PersonViewModel())
    
}
