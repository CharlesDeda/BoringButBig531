//
//  TableView.swift
//  BoringButBig531
//
//  Created by Nick Deda on 6/4/24.
//
//struct Customer: Identifiable {
//  let id = UUID()
//  let name: String
//  let email: String
//  let date: String
//}
//
//
//import SwiftUI
//
//struct TableView: View {
//  @State var customers = [
//    Customer(
//      name: "Kody",
//      email: "Kdeda@id-design.com",
//      date: "11/24/31"),
//    Customer(
//      name: "Nick",
//      email: "Ndeda@id-design.com",
//      date: "11/14/31")
//  ]
//  
//  var body: some View {
//    Table(customers) {
//      TableColumn("Name", value: \.name)
//      TableColumn("Email", value: \.email)
//      TableColumn("Date", value: \.date)
//      //    } rows: {
//      //      ForEach(customers) { customer in
//      //        TableRow(customer)
//      //      }
//      //      TableRow(Customer(name: "Nick", email: "Gers", date: ""))
//      //    }
//    }
//  }
//}
//
//struct TableView_Previews: PreviewProvider {
//  static var previews: some View {
//    TableView()
//  }
//}
