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
    @EnvironmentObject var hymnSingVM: HymnSingViewModel
    @EnvironmentObject var personVM: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Name").bold()
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Name", text: $name).padding(.horizontal)
                }.frame(height: 50.0)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Description").bold()
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Description", text: $description).padding(.horizontal).lineLimit(3)
                }.frame(height: 50.0)
            }
            VStack(alignment: .leading, spacing: 10) {
                DatePicker("Date", selection: $date, displayedComponents: .date).bold()
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
                            .font(.custom("HelveticaNeue-Light", size: 12))
                    }
                }
            }.sheet(isPresented: $showSheet){
                LocationPicker(instructions: "Pick a location", coordinates: $location)
            }
            Button {
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
                hymnSingVM.postHymnSing(hymnSing: hymnSing)
                personVM.mutateHymnSings(hymnSing: hymnSing)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.blue)
                    Text("Add Hymn Sing").foregroundStyle(.white).padding(.horizontal)
                }.frame(height: 50.0)
            }
            Spacer()
        }.navigationTitle("Add Hymn Sing").padding(.horizontal)
    }
}

#Preview {
    AddHymnSingView().environmentObject(HymnSingViewModel()).environmentObject(PersonViewModel())
    
}
