//
//  ContentView.swift
//  Thumbmark Swift Example
//
//  Created by Brandon Stillitano on 16/4/2024.
//

import SwiftUI
import Thumbmark

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    RowContent(title: "ID", subtitle: Thumbmark.instance.id)
                    RowContent(title: "Vendor ID", subtitle: Thumbmark.instance.vendorId?.uuidString)
                }
                Section {
                    ForEach(Thumbmark.instance.fingerprint.captureDevices, id: \.id) { value in
                        RowContent(title: value.name, subtitle: "ID: \(value.id)\nModel: \(value.modelId)\nPosition: \(value.position)")
                    }
                } header: {
                    Text("Capture devices")
                }
                Section {
                    RowContent(title: "Total cores", subtitle: Thumbmark.instance.fingerprint.processor.processorCount.description)
                    RowContent(title: "Active cores", subtitle: Thumbmark.instance.fingerprint.processor.activeProcessors.description)
                    RowContent(title: "Architecture", subtitle: Thumbmark.instance.fingerprint.processor.architecture)
                    RowContent(title: "Kernel version", subtitle: Thumbmark.instance.fingerprint.processor.kernelVersion.description)
                } header: {
                    Text("Processor")
                }
                Section {
                    RowContent(title: "Machine", subtitle: Thumbmark.instance.fingerprint.device.machine)
                    RowContent(title: "Model", subtitle: Thumbmark.instance.fingerprint.device.model)
                    RowContent(title: "Host name", subtitle: Thumbmark.instance.fingerprint.device.hostName)
                    RowContent(title: "Device name", subtitle: Thumbmark.instance.fingerprint.device.deviceName)
                    RowContent(title: "OS release", subtitle: Thumbmark.instance.fingerprint.device.osRelease)
                    RowContent(title: "OS version", subtitle: Thumbmark.instance.fingerprint.device.osVersion)
                } header: {
                    Text("Device")
                }
                Section {
                    RowContent(title: "RAM", subtitle: Thumbmark.instance.fingerprint.memory.ram.description)
                    RowContent(title: "Disk size", subtitle: Thumbmark.instance.fingerprint.memory.diskSize.description)
                } header: {
                    Text("Memory")
                }
                Section {
                    RowContent(title: "isBoldTextEnabled", subtitle: Thumbmark.instance.fingerprint.accessibility.isBoldTextEnabled.description)
                    RowContent(title: "isShakeToUndoEnabled", subtitle: Thumbmark.instance.fingerprint.accessibility.isShakeToUndoEnabled.description)
                    RowContent(title: "isReduceMotionEnabled", subtitle: Thumbmark.instance.fingerprint.accessibility.isReduceMotionEnabled.description)
                    RowContent(title: "isDarkerSystemColorsEnabled", subtitle: Thumbmark.instance.fingerprint.accessibility.isDarkerSystemColorsEnabled.description)
                    RowContent(title: "isReduceTransparencyEnabled", subtitle: Thumbmark.instance.fingerprint.accessibility.isReduceTransparencyEnabled.description)
                    RowContent(title: "isAssistiveTouchRunning", subtitle: Thumbmark.instance.fingerprint.accessibility.isAssistiveTouchRunning.description)
                    RowContent(title: "preferredContentSizeCategory", subtitle: Thumbmark.instance.fingerprint.accessibility.preferredContentSizeCategory)
                } header: {
                    Text("Accessibility")
                }
                Section {
                    RowContent(title: "identifier", subtitle: Thumbmark.instance.fingerprint.locality.identifier)
                    RowContent(title: "languageCode", subtitle: Thumbmark.instance.fingerprint.locality.languageCode)
                    RowContent(title: "regionCode", subtitle: Thumbmark.instance.fingerprint.locality.regionCode)
                    RowContent(title: "availableRegionCodes", subtitle: Thumbmark.instance.fingerprint.locality.availableRegionCodes.formatted())
                    RowContent(title: "calendarIdentifier", subtitle: Thumbmark.instance.fingerprint.locality.calendarIdentifier)
                    RowContent(title: "timezone", subtitle: Thumbmark.instance.fingerprint.locality.timezone)
                    RowContent(title: "availableTimezones", subtitle: Thumbmark.instance.fingerprint.locality.availableTimezones.formatted())
                    RowContent(title: "availableKeyboards", subtitle: Thumbmark.instance.fingerprint.locality.availableKeyboards.formatted())
                    RowContent(title: "twentyFourHourTimeEnabled", subtitle: Thumbmark.instance.fingerprint.locality.twentyFourHourTimeEnabled.description)
                    RowContent(title: "temperatureUnit", subtitle: Thumbmark.instance.fingerprint.locality.temperatureUnit)
                    RowContent(title: "usesMetricSystem", subtitle: Thumbmark.instance.fingerprint.locality.usesMetricSystem.description)
                } header: {
                    Text("Locality")
                }
                Section {
                    RowContent(title: "canSendMail", subtitle: Thumbmark.instance.fingerprint.communication.canSendMail.description)
                    RowContent(title: "canSendMesages", subtitle: Thumbmark.instance.fingerprint.communication.canSendMessages.description)
                    RowContent(title: "canSendSubject", subtitle: Thumbmark.instance.fingerprint.communication.canSendSubject.description)
                    RowContent(title: "canSendAttachments", subtitle: Thumbmark.instance.fingerprint.communication.canSendAttachments.description)
                } header: {
                    Text("Communication")
                }
            }
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
