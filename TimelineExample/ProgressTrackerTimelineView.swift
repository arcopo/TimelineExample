//  Copyright (c) 2025 Commonwealth Bank. All rights reserved.

import SwiftUI

/// Displays the timeline (dashed line with an icon) for a progress tracker step.
///
/// This view draws a dashed vertical line and places the step indicator icon in the correct position
/// based on the timeline position (first, middle, last, or none). The dashed pattern and icon are
/// designed to match the Figma spec for the Progress Tracker.
///
/// [Figma reference](https://www.figma.com/design/d5nxem1piXkREvJcLmvUdL/%F0%9F%9A%A7-Progress-Tracker-(Web-%2B-App)?node-id=2227-29078&p=f&t=xcxMNS4QrRpGCqus-0)


public struct ProgressTrackerTimelineView: View {
    let stepIndicator: StepIndicator
    let timelinePosition: TimelinePosition

    public var body: some View {
        VStack(spacing: 0) {
            switch timelinePosition {
            case .first:
                // For the first step, display the icon at the top, then a dashed line extending downward.
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 2, height: 10, alignment: .center)
                stepIndicator.image
                Rectangle()
                    .fill(Color.clear)
                    
                    .frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: nil, idealHeight: nil, maxHeight: .infinity)
                    .overlay(DashPatternOverlay())
                    // arcopo make the fill clear and no foreground
            case .middle:
                // For a middle step, draw a dashed line above, the icon, and a dashed line below.
                Rectangle()
                    .fill(Color.clear)
                    .frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: nil, idealHeight: nil, maxHeight: .infinity)
                    .overlay(DashPatternOverlay())
                stepIndicator.image
                Rectangle()
                    .fill(Color.clear)
                    .frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: nil, idealHeight: nil, maxHeight: .infinity)
                    .overlay(DashPatternOverlay())
            case .last:
                // For the last step, draw a dashed line above, then the icon.
                Rectangle()
                    .fill(Color.clear)
                    .frame(minWidth: 1, idealWidth: 1, maxWidth: 1, minHeight: nil, idealHeight: nil, maxHeight: .infinity)
                    .overlay(DashPatternOverlay())
                stepIndicator.image
            case .none:
                // If no timeline is required, just show the icon.
                stepIndicator.image
            }
        }
        .frame(width: 30)
        .background(Color.green)
    }
}

/// A helper view that draws a dashed line pattern.
///
/// This view uses a simple path with a dash style to overlay a dashed line.
struct DashPatternOverlay: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 0, y: geo.size.height))
            }
            .strokedPath(StrokeStyle(lineWidth: 2, dash: [8, 8]))
            .foregroundColor(.secondary)
            // arcopo make the spacing a bit bigger
        }
    }
}


#Preview {
    ProgressTrackerTimelineView(stepIndicator: .complete, timelinePosition: .first)
}
