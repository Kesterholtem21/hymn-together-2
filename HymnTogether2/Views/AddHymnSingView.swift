//
//  AddHymnSingView.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import SwiftUI

struct AddHymnSingView: View {
    @State var name = ""
    @State var lead = ""
    @State var description = ""
    @State var latitude: Double = 0.0
    @State var longitude: Double = 0.0
    @EnvironmentObject var VM: HymnSingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Add Hymn Sing").bold().font(.title)
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Name").bold()
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Name", text: $name).padding(.horizontal)
                }.frame(height: 50.0)
            }
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Lead").bold()
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Lead", text: $lead).padding(.horizontal)
                }.frame(height: 50.0)
            }
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Description").bold()
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                    TextField("Description", text: $description).padding(.horizontal).lineLimit(3)
                }.frame(height: 50.0)
            }
            
            HStack{
                VStack(alignment: .leading, spacing: 10) {
                    Text("Latitude").bold()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                        TextField("Latitude", text: $name).padding(.horizontal)
                    }.frame(height: 50.0)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Longitude").bold()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0).fill(.gray).opacity(0.1)
                        TextField("Longitude", text: $name).padding(.horizontal)
                    }.frame(height: 50.0)
                }
            }
            
            
            Button{
                VM.hymnSings.append(HymnSingModel(personId: "1", name: name, lead: lead, description: description, longitude: 0.0, latitude: 0.0))
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(.blue)
                    Text("Add Hymn Sing").foregroundStyle(.white).padding(.horizontal)
                }.frame(height: 50.0)
            }
            
            
            
        }.navigationTitle("Add Hymn Sing").padding(.horizontal)
    }
}

#Preview {
    AddHymnSingView().environmentObject(HymnSingViewModel())
    
}
