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
    @EnvironmentObject var VM: HymnSingViewModel
    @EnvironmentObject var personVM: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()
            //Text("Create Your Own Hymn Sing").bold().font(.title)
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
            
            
            
            
//            HStack(spacing: 10) {
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Latitude").bold()
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
//                        TextField("Latitude", value: $latitude, formatter: NumberFormatter()).padding(.horizontal)
//                    }.frame(height: 50.0)
//                }
//                
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Longitude").bold()
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
//                        TextField("Longitude", value: $longitude, formatter: NumberFormatter()).padding(.horizontal)
//                    }.frame(height: 50.0)
//                }
//            }
           
            VStack(alignment: .leading, spacing: 10) {
//                Text("Date").bold()
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
//                    TextField("Name", text: $name).padding(.horizontal)
//                }.frame(height: 50.0)
                DatePicker("Date of Hymn Sing: ", selection: $date, displayedComponents: .date).padding(.horizontal).bold()
            }.padding(.vertical)
            
            
            Button{
                showSheet = true
            }label: {
                Text("Current Location: \(location.latitude), \(location.longitude)")
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10.0).fill(.green)
                    Text("Pick a location").foregroundStyle(.white).padding(.horizontal)
                }.frame(height: 50.0)
            }.sheet(isPresented: $showSheet){
                LocationPicker(instructions: "Pick a location", coordinates: $location)
            }
            
            Button{
                VM.hymnSings.append(HymnSingModel(personId: personVM.person.id, name: name, lead: personVM.person.name, description: description, longitude: location.longitude, latitude: location.latitude, date: date))
                
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
