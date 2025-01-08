//
//  WebSocketClient.swift
//  WebSocketClient
//
//  Created by digital on 22/10/2024.
//

import SwiftUI
import NWWebSocket
import Network

class WebSocketClient:ObservableObject {
    
    static let instance = WebSocketClient()
    
    
    var routes = [String:NWWebSocket]()
    
    var ipAdress = "192.168.10.244:8080/"
    
    @Published var receivedMessage:String? = ""
    
    func connect(route:String){
        if let socketURL = URL(string: "ws://\(ipAdress)\(route)") {
            var socket = NWWebSocket(url: socketURL, connectAutomatically: false)
            socket.delegate = self
            
            // Use the WebSocket…
            socket.connect()
            routes[route] = socket
        }
    }
    
    func disconectRoute(route:String){
        routes[route]?.disconnect()
    }
    
    func sendText(route:String ,data:String){
        
        if let socketURL = URL(string: "ws://\(ipAdress)\(route)") {
            var socket = NWWebSocket(url: socketURL, connectAutomatically: false)
            socket.delegate = self
            
            // Use the WebSocket…
            
            socket.connect()
            routes[route] = socket
            socket.send(string: data)

        }

    }
    

}







extension WebSocketClient: WebSocketConnectionDelegate {

    func webSocketDidConnect(connection: WebSocketConnection) {
        // Respond to a WebSocket connection event
        print("did connect")
    }

    func webSocketDidDisconnect(connection: WebSocketConnection,
                                closeCode: NWProtocolWebSocket.CloseCode, reason: Data?) {
        // Respond to a WebSocket disconnection event
        print("did disconnect")
    }

    func webSocketViabilityDidChange(connection: WebSocketConnection, isViable: Bool) {
        // Respond to a WebSocket connection viability change event
        print("viability \(isViable)")
    }

    func webSocketDidAttemptBetterPathMigration(result: Result<WebSocketConnection, NWError>) {
        // Respond to when a WebSocket connection migrates to a better network path
        // (e.g. A device moves from a cellular connection to a Wi-Fi connection)
    }

    func webSocketDidReceiveError(connection: WebSocketConnection, error: NWError) {
        // Respond to a WebSocket error event
        print("error \(error)")
    }

    func webSocketDidReceivePong(connection: WebSocketConnection) {
        // Respond to a WebSocket connection receiving a Pong from the peer
        print("received pong")
    }

    func webSocketDidReceiveMessage(connection: WebSocketConnection, string: String) {
        // Respond to a WebSocket connection receiving a `String` message
        receivedMessage = string
        print("received \(string)")
    }

    func webSocketDidReceiveMessage(connection: WebSocketConnection, data: Data) {
        // Respond to a WebSocket connection receiving a binary `Data` message
        print("received \(data)")
    }
}
