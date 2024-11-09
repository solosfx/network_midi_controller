import Flutter
import UIKit
import CoreMIDI
import Network

public class NetworkMidiControllerPlugin: NSObject, FlutterPlugin {
    
    private let midiController = MidiControllerManager()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "network_midi_controller", binaryMessenger: registrar.messenger())
        let instance = NetworkMidiControllerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "initialize" {
            midiController.initialize()
            result(nil)
        } else if call.method == "sendMIDICommand" {
            if let args = call.arguments as? [String: Any],
               let command = args["command"] as? UInt8,
               let note = args["note"] as? UInt8,
               let velocity = args["velocity"] as? UInt8 {
                midiController.sendMIDICommand(command: command, note: note, velocity: velocity)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for sendMIDICommand", details: nil))
            }
        } else if call.method == "getPlatform" {
            result("iOS")
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}

class MidiControllerManager {
    private var midiSender: MIDISender?
    
    func initialize() {
        midiSender = MIDISender()
    }
    
    func sendMIDICommand(command: UInt8, note: UInt8, velocity: UInt8) {
        midiSender?.sendMIDICommand(command: command, note: note, velocity: velocity)
    }
}

class MIDISender {
    private var midiClient: MIDIClientRef = 0
    private var midiOutPort: MIDIPortRef = 0
    private var session: MIDINetworkSession
    
    init() {
        // Set up the MIDI network session
        session = MIDINetworkSession.default()
        session.isEnabled = true
        session.connectionPolicy = .anyone
        MIDIClientCreate("MIDI Controller Client" as CFString, nil, nil, &midiClient)
        MIDIOutputPortCreate(midiClient, "MIDI Controller Port" as CFString, &midiOutPort)
    }
    
    func sendMIDICommand(command: UInt8, note: UInt8, velocity: UInt8) {
        var packetList: MIDIPacketList = MIDIPacketList(numPackets: 1, packet: MIDIPacket())
        let packet = MIDIPacketListInit(&packetList)
        
        let midiMessage: [UInt8] = [command, note, velocity]
        MIDIPacketListAdd(&packetList, 1024, packet, 0, midiMessage.count, midiMessage)
        
        // Send MIDI Command and Note to all connected destinations
        for index in 0..<MIDIGetNumberOfDestinations() {
            let destiny = MIDIGetDestination(index)
            MIDISend(midiOutPort, destiny, &packetList)
        }
    }
}
