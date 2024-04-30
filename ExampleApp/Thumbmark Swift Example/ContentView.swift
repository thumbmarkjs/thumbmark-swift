//
//  ContentView.swift
//  Thumbmark Swift Example
//
//  Created by Brandon Stillitano on 16/4/2024.
//

import SwiftUI
import Thumbmark

struct ContentView: View {
    @State var id: String = ""
    @State var persistentId: String = ""
    @State var fingerprint: Fingerprint?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    RowContent(title: "ID", subtitle: id)
                    RowContent(title: "Persistent ID", subtitle: persistentId)
                }
                if fingerprint?.captureDevices?.isEmpty == false {
                    Section {
                        ForEach(fingerprint?.captureDevices ?? [], id: \.id) { value in
                            RowContent(title: value.name, subtitle: "ID: \(value.id)\nModel: \(value.modelId)\nPosition: \(value.position)")
                        }
                    } header: {
                        Text("Capture devices")
                    }
                }
                Section {
                    RowContent(title: "Total cores", subtitle: fingerprint?.processor?.processorCount.description)
                    RowContent(title: "Active cores", subtitle: fingerprint?.processor?.activeProcessors.description)
                    RowContent(title: "Architecture", subtitle: fingerprint?.processor?.architecture)
                    RowContent(title: "Kernel version", subtitle: fingerprint?.processor?.kernelVersion.description)
                } header: {
                    Text("Processor")
                }
                Section {
                    RowContent(title: "Machine", subtitle: fingerprint?.device?.machine)
                    RowContent(title: "Model", subtitle: fingerprint?.device?.model)
                    RowContent(title: "Host name", subtitle: fingerprint?.device?.hostName)
                    RowContent(title: "Device name", subtitle: fingerprint?.device?.deviceName)
                    RowContent(title: "OS release", subtitle: fingerprint?.device?.osRelease)
                    RowContent(title: "OS version", subtitle: fingerprint?.device?.osVersion)
                } header: {
                    Text("Device")
                }
                Section {
                    RowContent(title: "RAM", subtitle: fingerprint?.memory?.ram.description)
                    RowContent(title: "Disk size", subtitle: fingerprint?.memory?.diskSize.description)
                } header: {
                    Text("Memory")
                }
                Section {
                    RowContent(title: "isBoldTextEnabled", subtitle: fingerprint?.accessibility?.isBoldTextEnabled.description)
                    RowContent(title: "isShakeToUndoEnabled", subtitle: fingerprint?.accessibility?.isShakeToUndoEnabled.description)
                    RowContent(title: "isReduceMotionEnabled", subtitle: fingerprint?.accessibility?.isReduceMotionEnabled.description)
                    RowContent(title: "isDarkerSystemColorsEnabled", subtitle: fingerprint?.accessibility?.isDarkerSystemColorsEnabled.description)
                    RowContent(title: "isReduceTransparencyEnabled", subtitle: fingerprint?.accessibility?.isReduceTransparencyEnabled.description)
                    RowContent(title: "isAssistiveTouchRunning", subtitle: fingerprint?.accessibility?.isAssistiveTouchRunning.description)
                    RowContent(title: "preferredContentSizeCategory", subtitle: fingerprint?.accessibility?.preferredContentSizeCategory)
                } header: {
                    Text("Accessibility")
                }
                Section {
                    RowContent(title: "identifier", subtitle: fingerprint?.locality?.identifier)
                    RowContent(title: "languageCode", subtitle: fingerprint?.locality?.languageCode)
                    RowContent(title: "regionCode", subtitle: fingerprint?.locality?.regionCode)
                    RowContent(title: "availableRegionCodes", subtitle: fingerprint?.locality?.availableRegionCodes.formatted())
                    RowContent(title: "calendarIdentifier", subtitle: fingerprint?.locality?.calendarIdentifier)
                    RowContent(title: "timezone", subtitle: fingerprint?.locality?.timezone)
                    RowContent(title: "availableTimezones", subtitle: fingerprint?.locality?.availableTimezones.formatted())
                    RowContent(title: "availableKeyboards", subtitle: fingerprint?.locality?.availableKeyboards.formatted())
                    RowContent(title: "twentyFourHourTimeEnabled", subtitle: fingerprint?.locality?.twentyFourHourTimeEnabled.description)
                    RowContent(title: "temperatureUnit", subtitle: fingerprint?.locality?.temperatureUnit)
                    RowContent(title: "usesMetricSystem", subtitle: fingerprint?.locality?.usesMetricSystem.description)
                } header: {
                    Text("Locality")
                }
                Section {
                    RowContent(title: "canSendMail", subtitle: fingerprint?.communication?.canSendMail.description)
                    RowContent(title: "canSendMesages", subtitle: fingerprint?.communication?.canSendMessages.description)
                    RowContent(title: "canSendSubject", subtitle: fingerprint?.communication?.canSendSubject.description)
                    RowContent(title: "canSendAttachments", subtitle: fingerprint?.communication?.canSendAttachments.description)
                } header: {
                    Text("Communication")
                }
            }
        }.task {
            fingerprint = await Thumbmark.instance.fingerprint
            id = await Thumbmark.instance.id ?? "N/A"
            persistentId = await Thumbmark.instance.persistentId()?.uuidString ?? "N/A"
        }
    }

    @ViewBuilder func RowContent(title: String, subtitle: String?) -> some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(title))
                .font(.body)
            if let subtitle = subtitle {
                Text(LocalizedStringKey(subtitle))
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
